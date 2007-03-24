#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAI.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.2, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } w5eKF461Eep4mjTerVpQKg
# $Id: AdanaxisAI.rb,v 1.14 2007/03/24 14:06:27 southa Exp $
# $Log: AdanaxisAI.rb,v $
# Revision 1.14  2007/03/24 14:06:27  southa
# Cistern AI
#
# Revision 1.13  2007/03/13 21:45:06  southa
# Release process
#
# Revision 1.12  2007/03/06 21:05:16  southa
# Level work
#
# Revision 1.11  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.10  2006/11/01 13:04:20  southa
# Initial weapon handling
#
# Revision 1.9  2006/10/15 17:12:53  southa
# Scripted explosions
#
# Revision 1.8  2006/10/13 14:21:25  southa
# Collision handling
#
# Revision 1.7  2006/10/12 22:04:45  southa
# Collision events
#
# Revision 1.6  2006/10/03 14:06:49  southa
# Khazi and projectile creation
#
# Revision 1.5  2006/10/02 20:28:09  southa
# Object lookup and target selection
#
# Revision 1.4  2006/10/02 17:25:03  southa
# Object lookup and target selection
#
# Revision 1.3  2006/09/30 13:46:32  southa
# Seek and patrol
#
# Revision 1.2  2006/09/29 10:47:55  southa
# Object AI
#
# Revision 1.1  2006/08/24 09:58:51  southa
# File addition
#

require 'AdanaxisTargetSelect.rb'

class AdanaxisAI < MushObject
  AISTATE_INVALID=0
  AISTATE_NONE=1
  AISTATE_DORMANT=2
  AISTATE_IDLE=3
  AISTATE_PATROL=4
  AISTATE_SEEK=5
  AISTATE_WAYPOINT=6
  AISTATE_PROJECTILE_SEEK=7
  AISTATE_RAM=8

  def initialize(inParams = {})
    @m_state = AISTATE_DORMANT
    @m_stateDuration = 0
    @m_stateChangeMsec = 0
    @r_piece = nil
    @r_post = nil
    
    # Parameters
    @m_targetID = inParams[:target_id]
    @m_ramSpeed = inParams[:ram_speed] || 0.0
    @m_ramAcceleration = inParams[:ram_acceleration] || 0.0
    @m_seekSpeed = inParams[:seek_speed] || 0.0
    @m_seekAcceleration = inParams[:seek_acceleration] || 0.0
    @m_patrolAcceleration = inParams[:patrol_acceleration] || 0.0
    @m_patrolPoints = inParams[:patrol_points] || []
    @m_patrolSpeed = inParams[:patrol_speed] || 0.0
    @m_targetTypes = inParams[:target_types] || "p"
    @m_overrideDeadMsec = inParams[:override_dead_msec] || 10000
    @m_lastOverrideMsec = nil
    @m_waypoint = inParams[:waypoint] || MushVector.new(rand(300)-150, rand(300)-150, rand(300)-150, -rand(300)-50)
    @m_waypointMsec = inParams[:waypoint_msec]

    case inParams[:ai_state]
    when :patrol
      mStateChangePatrol(inParams[:ai_state_msec])
    end
  end

  def mTargetSelect
    @m_targetID = AdanaxisTargetSelect.cSelect(@r_post, @m_targetTypes, @r_piece.mId)
    nil
  end

  def mTargetOverride(inTargetID)
    @m_lastOverrideMsec = MushUtil.cIntervalTest(@m_lastOverrideMsec, @m_overrideDeadMsec) do
      @m_targetID = inTargetID
    end
  end

  def mStateChange(newState)
    @m_state = newState
    @m_stateChangeMsec = MushGame.cGameMsec
    nil
  end

  def mStateChangeDormant
    mStateChange(AISTATE_DORMANT)
  end
  
  def mStateChangeIdle
    mStateChange(AISTATE_IDLE)
  end
  
  def mStateChangeRam(duration)
    @m_stateDuration = duration
    mTargetSelect unless @m_targetID
    mStateChange(AISTATE_RAM)
    nil
  end

  def mStateChangeSeek(duration)
    @m_stateDuration = duration
    mTargetSelect unless @m_targetID
    mStateChange(AISTATE_SEEK)
    nil
  end

  def mStateChangePatrol(duration = nil)
    @m_stateDuration = duration
    @m_patrolIndex = 0
    @m_patrolPoint = @m_patrolPoints[@m_patrolIndex]
    if !@m_patrolPoint
      mStateChange(AISTATE_DORMANT)
      raise(RuntimeError, 'Patrol state entered without patrol points')
    end
    mStateChange(AISTATE_PATROL)
    nil
  end

  def mStateChangeWaypoint(duration, waypoint)
    @m_waypoint = waypoint
    @m_stateDuration = duration
    mStateChange(AISTATE_WAYPOINT)
    nil
  end

  def mMsecSinceStateChange
    MushGame.cGameMsec - @m_stateChangeMsec
  end

  def mStateExpired?
    return @m_stateDuration && mMsecSinceStateChange > @m_stateDuration
  end

  def mStateActionPatrolExit
    mStateChangeDormant
  end
  
  def mStateActionPatrolNextPoint
    @m_patrolIndex += 1
    @m_patrolIndex = 0 if @m_patrolIndex >= @m_patrolPoints.size
    @m_patrolPoint = @m_patrolPoints[@m_patrolIndex]
  end

  def mStateActionPatrol
    if @m_patrolPoint
      distToPoint2 = (@m_patrolPoint - @r_post.position).mMagnitudeSquared
      if distToPoint2 < 100.0 * @m_patrolSpeed * @m_patrolSpeed
        mStateActionPatrolNextPoint
      end
      
      MushUtil.cRotateAndSeek(@r_post,
        @m_patrolPoint, # Target
        @m_patrolSpeed, # Maximum speed
        @m_patrolAcceleration # Acceleration
      )
    end
    
    100
  end

  def mStateActionRamExit
    mStateChangeDormant
  end

  def mStateActionRam
    onTarget = false
    mTargetSelect unless @m_targetID
    unless @m_targetID
      # No target to seek
      mStateChangeIdle
    else
      begin
        targetPiece = MushGame.cPieceLookup(@m_targetID)
        targetPos = targetPiece.post.position
        onTarget = MushUtil.cRotateAndSeek(@r_post,
          targetPos, # Target
          @m_ramSpeed, # Maximum speed
          @m_ramAcceleration # Acceleration
        )
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end
    
    100
  end

  def mStateActionSeekExit
    mStateChangeDormant
  end

  def mStateActionSeek
    onTarget = false
    mTargetSelect unless @m_targetID
    unless @m_targetID
      # No target to seek
      mStateChangeIdle
    else
      begin
        targetPiece = MushGame.cPieceLookup(@m_targetID)
        targetPos = targetPiece.post.position
        onTarget = MushUtil.cRotateAndSeek(@r_post,
          targetPos, # Target
          @m_seekSpeed, # Maximum speed
          @m_seekAcceleration # Acceleration
        )
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end
    
    @r_piece.mFire if onTarget
    
    100
  end

  def mStateActionWaypoint
    MushUtil.cRotateAndSeek(@r_post,
      @m_waypoint, # Target
      @m_patrolSpeed, # Maximum speed
      @m_patrolAcceleration # Acceleration
    )
    
    if mStateExpired?
      mStateChangeSeek(60000)
    end
      
    100
  end
  
  def mActMain
    callInterval = 100

    case @m_state
      when AISTATE_IDLE : mStateChange(AISTATE_DORMANT)
      when AISTATE_DORMANT :
        if @m_waypointMsec
          mStateChangeWaypoint(@m_waypointMsec, @m_waypoint)
        else
          mStateChangeSeek(15000)
        end
      when AISTATE_PATROL
        callInterval = mStateActionPatrol
        mStateActionPatrolExit if mStateExpired?
      when AISTATE_RAM
        callInterval = mStateActionRam
        mStateActionRamExit if mStateExpired?
      when AISTATE_SEEK
        callInterval = mStateActionSeek
        mStateActionPatrolExit if mStateExpired?
      else raise MushError.new("Bad aiState value #{@m_state}") 
    end

    callInterval
  end

  def mActPrologue(ioPiece)
    @r_piece = ioPiece
    @r_post = ioPiece.mPostWRef
  end

  def mActEpilogue
  end

  def mActByState(ioPiece)
    begin
      mActPrologue(ioPiece)
      callInterval = mActMain
      mActEpilogue
    rescue
      mStateChange(AISTATE_IDLE)
      raise
    end  
    callInterval
  end

end
