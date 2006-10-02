#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAI.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } ZJhgffsl43t4RqQcN4aPag
# $Id: AdanaxisAI.rb,v 1.4 2006/10/02 17:25:03 southa Exp $
# $Log: AdanaxisAI.rb,v $
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

class AdanaxisAI
  AISTATE_INVALID=0
  AISTATE_NONE=1
  AISTATE_DORMANT=2
  AISTATE_IDLE=3
  AISTATE_PATROL=4
  AISTATE_SEEK=5
  AISTATE_WAYPOINT=6

  def initialize
    super
    @m_state = AISTATE_DORMANT
    @m_stateDuration = 0
    @m_waypoint = MushVector.new(rand(300)-150, rand(300)-150, rand(300)-150, -rand(300)-50)
    @m_stateChangeMsec = 0
    @m_targetID = nil
    @r_piece
    @r_post
  end

  def mTargetSelect
    @m_targetID = AdanaxisTargetSelect.cSelect(@r_post, "kp", @r_piece.m_id)
    nil
  end

  def mStateChange(newState)
    @m_state = newState
    @m_stateChangeMsec = MushGame.cGameMsec
    nil
  end

  def mStateChangeSeek(duration)
    @m_stateDuration = duration
    mTargetSelect unless @m_targetID
    mStateChange(AISTATE_SEEK)
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
    (mMsecSinceStateChange > @m_stateDuration)
  end

  def mStateActionSeek
    mTargetSelect unless @m_targetID
    unless @m_targetID
      # No target to seek
      mStateChange(AISTATE_IDLE)
    else
      targetPos = nil
      begin
        targetPiece = MushGame.cPieceLookup(@m_targetID)
        targetPos = targetPiece.post.position
      rescue Exception => e
        # Target probably destroyed
        mTargetSelect
        targetPos = AdanaxisRuby.cPlayerPosition
      end
      MushUtil.cRotateAndSeek(@r_post,
        targetPos, # Target
        0.10, # Maximum speed
        0.01 # Acceleration
      )
    end
    
    if mStateExpired?
      mStateChangeWaypoint(10000, @m_waypoint)
    end
    
    100
  end

  def mStateActionWaypoint
    MushUtil.cRotateAndSeek(@r_post,
      @m_waypoint, # Target
      1.0, # Maximum speed
      0.01 # Acceleration
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
      when AISTATE_DORMANT : mStateChangeSeek(15000)
      when AISTATE_SEEK : callInterval = mStateActionSeek
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
