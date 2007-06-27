#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAI.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } jdaTlpT5VDypkvAKnvFTkQ
# $Id: AdanaxisAI.rb,v 1.25 2007/06/27 12:58:09 southa Exp $
# $Log: AdanaxisAI.rb,v $
# Revision 1.25  2007/06/27 12:58:09  southa
# Debian packaging
#
# Revision 1.24  2007/06/14 12:14:14  southa
# Level 30
#
# Revision 1.23  2007/06/13 14:08:41  southa
# Level 29
#
# Revision 1.22  2007/05/24 15:13:49  southa
# Level 17
#
# Revision 1.21  2007/05/08 15:28:13  southa
# Level 12
#
# Revision 1.20  2007/04/26 13:12:38  southa
# Limescale and level 9
#
# Revision 1.19  2007/04/18 09:21:51  southa
# Header and level fixes
#
# Revision 1.18  2007/04/17 21:16:33  southa
# Level work
#
# Revision 1.17  2007/03/28 14:45:45  southa
# Level and AI standoff
#
# Revision 1.16  2007/03/27 14:01:02  southa
# Attendant AI
#
# Revision 1.15  2007/03/24 18:07:22  southa
# Level 3 work
#
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
  AISTATE_EVADE=9

  def initialize(inParams = {})
    @m_state = AISTATE_DORMANT
    @m_stateDuration = 0
    @m_stateChangeMsec = 0
    @r_piece = nil
    @r_post = nil

    # Parameters
    @m_targetID = inParams[:target_id]
    @m_evadeAcceleration = inParams[:evade_acceleration] || 0
    @m_evadeSpeed = inParams[:evade_speed] || 0
    @m_patrolAcceleration = inParams[:patrol_acceleration] || 0
    @m_patrolPoints = inParams[:patrol_points] || [MushVector.new(0,0,0,0)]
    @m_patrolSpeed = inParams[:patrol_speed] || 0
    @m_ramAcceleration = inParams[:ram_acceleration] || 0
    @m_ramSpeed = inParams[:ram_speed] || 0
    @m_seekAcceleration = inParams[:seek_acceleration] || 0
    @m_seekSpeed = inParams[:seek_speed] || 0
    @m_seekStandOff = inParams[:seek_stand_off] || 0
    @m_targetTypes = inParams[:target_types] || "p"
    @m_overrideDeadMsec = inParams[:override_dead_msec] || 10000
    @m_lastOverrideMsec = nil

    case inParams[:ai_state]
    when :dormant
      mStateChangeDormant(inParams[:ai_state_msec])
    when :evade
      mStateChangeEvade(inParams[:ai_state_msec])
    when :patrol
      mStateChangePatrol(inParams[:ai_state_msec])
    when :seek
      mStateChangeSeek(inParams[:ai_state_msec])
    when :waypoint
      mStateChangeWaypoint(inParams[:waypoint], inParams[:ai_state_msec])
    end
  end

  mush_reader :m_targetID

  def mFire
    @r_piece.mFire
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

  def mStateChangeDormant(duration)
    @m_stateDuration = duration
    mStateChange(AISTATE_DORMANT)
  end

  def mStateChangeEvade(duration)
    @m_stateDuration = duration
    @m_evadePoint = nil
    mStateChange(AISTATE_EVADE)
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

  def mStateChangeWaypoint(waypoint, duration = nil)
    @m_stateDuration = duration
    @m_waypoint = waypoint
    if !@m_waypoint
      mStateChange(AISTATE_DORMANT)
      raise(RuntimeError, 'Waypoint state entered without waypoint')
    end
    mStateChange(AISTATE_WAYPOINT)
    nil
  end

  def mMsecSinceStateChange
    MushGame.cGameMsec - @m_stateChangeMsec
  end

  def mStateExpired?
    return @m_stateDuration && mMsecSinceStateChange > @m_stateDuration
  end

  def mStateActionDormantExit
    mStateChangeIdle
  end

  def mStateActionDormant
    1000
  end

  def mStateActionEvadeExit
    mStateChangeIdle
  end

  def mStateActionEvade
    mTargetSelect unless @m_targetID
    unless @m_targetID
      # No target to seek
      mStateActionEvadeExit
    else
      @m_evadePoint = @r_post.position + MushTools.cRandomUnitVector * 100 unless @m_evadePoint

      distToPoint2 = (@m_evadePoint - @r_post.position).mMagnitudeSquared
      if distToPoint2 < 100.0 * @m_evadeSpeed * @m_evadeSpeed
        mStateActionEvadeExit
      end

      MushUtil.cRotateAndSeek(@r_post,
        @m_evadePoint, # Target
        @m_evadeSpeed, # Maximum speed
        @m_evadeAcceleration # Acceleration
      )
    end

    100
  end

  def mStateActionIdle
    1000
  end

  def mStateActionPatrolExit
    mStateChangeIdle
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
    mStateChangeIdle
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
    mStateChangeIdle
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
          @m_seekAcceleration, # Acceleration
          @m_seekStandOff # Stand off distance
        )
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end

    mFire if onTarget

    100
  end

  def mStateActionWaypointExit
    mStateChangeIdle
  end

  def mStateActionWaypoint
    distToPoint2 = (@m_waypoint - @r_post.position).mMagnitudeSquared
    if distToPoint2 < 100.0 * @m_patrolSpeed * @m_patrolSpeed
      mStateActionWaypointExit
    end

    MushUtil.cRotateAndSeek(@r_post,
      @m_waypoint, # Target
      @m_patrolSpeed, # Maximum speed
      @m_patrolAcceleration # Acceleration
    )

    100
  end

  def mActMain
    callInterval = 100

    case @m_state
      when AISTATE_DORMANT :
        callInterval = mStateActionDormant
        mStateActionDormantExit if mStateExpired?
      when AISTATE_EVADE
        callInterval = mStateActionEvade
        mStateActionEvadeExit if mStateExpired?
      when AISTATE_IDLE
        callInterval = mStateActionIdle
      when AISTATE_PATROL
        callInterval = mStateActionPatrol
        mStateActionPatrolExit if mStateExpired?
      when AISTATE_RAM
        callInterval = mStateActionRam
        mStateActionRamExit if mStateExpired?
      when AISTATE_SEEK
        callInterval = mStateActionSeek
        mStateActionSeekExit if mStateExpired?
      when AISTATE_WAYPOINT
        callInterval = mStateActionWaypoint
        mStateActionWaypointExit if mStateExpired?
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
