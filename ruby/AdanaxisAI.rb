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
# $Id: AdanaxisAI.rb,v 1.2 2006/09/29 10:47:55 southa Exp $
# $Log: AdanaxisAI.rb,v $
# Revision 1.2  2006/09/29 10:47:55  southa
# Object AI
#
# Revision 1.1  2006/08/24 09:58:51  southa
# File addition
#

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
    @m_waypoint = MushVector.new(0,0,0,0)
    @m_stateChangeMsec = 0
    @r_piece
    @r_post
  end

  def mStateChange(newState)
    @m_state = newState
    @m_stateChangeMsec = MushGame.cGameMsec
    nil
  end

  def mStateChangeSeek(duration)
    @m_stateDuration = duration
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
    MushUtil.cRotateAndSeek(@r_post,
      AdanaxisRuby.cPlayerPosition, # Target
      0.02, # Maximum speed
      0.01 # Acceleration
    )
    
    if mStateExpired?
      mStateChangeWaypoint(30000, MushVector.new(rand(30)-15, rand(30)-15, rand(30)-15, -30))
    end
    
    100
  end

  def mStateActionWaypoint
    MushUtil.cRotateAndSeek(@r_post,
      @m_waypoint, # Target
      0.10, # Maximum speed
      0.01 # Acceleration
    )
    
    if mStateExpired?
      mStateChangeSeek(15000)
    end
      
    100
  end
  
  def mActMain
    callInterval = 100

    case @m_state
      when AISTATE_IDLE : mStateChange(AISTATE_DORMANT)
      when AISTATE_DORMANT : mStateChangeSeek(15000)
      when AISTATE_SEEK : callInterval = mStateActionSeek
      else raise MushError.new("Bad aiState value @m_state") 
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
