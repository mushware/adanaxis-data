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
# $Id: AdanaxisAI.rb,v 1.1 2006/08/24 09:58:51 southa Exp $
# $Log: AdanaxisAI.rb,v $
# Revision 1.1  2006/08/24 09:58:51  southa
# File addition
#

module AdanaxisAI
  AISTATE_INVALID=0
  AISTATE_NONE=1
  AISTATE_DORMANT=2
  AISTATE_IDLE=3
  AISTATE_PATROL=4
  AISTATE_SEEK=5
  AISTATE_WAYPOINT=6

  def initialize
    super
    @aiState = AISTATE_DORMANT
    @aiWaypoint = MushVector.new(0,0,0,0)
    @aiWaypointDuration = 0
    @aiStateChangeMsec = 0
  end

  def mStateChange(newState)
    @aiState = newState
    @aiStateChangeMsec = MushGame.cGameMsec
  end

  def mStateChangeWaypoint(waypoint, duration)
    @aiWaypoint = waypoint
    @aiWaypointDuration = duration
    mStateChange(AISTATE_WAYPOINT)
  end

  def mMsecSinceStateChange
    MushGame.cGameMsec - @aiStateChangeMsec
  end

  def mStateActionSeek
    angVel = MushTools::cSlerp(@m_post.angular_velocity,
      MushTools.cTurnToFace(@m_post, AdanaxisRuby.cPlayerPosition, 0.05),
      0.2)
      
    angVel.mScale!(0.5)
    
    @m_post.angular_velocity = angVel
    @m_post.velocity *= 0.9
    
    if mMsecSinceStateChange > 5000
      mStateChangeWaypoint(MushVector.new(0,0,0,0), 5000)
    end
    
    100
  end

  def mStateActionWaypoint
    angVel = MushTools::cSlerp(@m_post.angular_velocity,
      MushTools.cTurnToFace(@m_post, @aiWaypoint, 0.05),
      0.2)
      
    angVel.mScale!(0.5)
    
    @m_post.angular_velocity = angVel
      
    distToPoint = (@aiWaypoint - @m_post.position).mMagnitude;
      
    accel = MushVector.new(0,0,0, -distToPoint / 100.0)
    @m_post.angular_position.mRotate(accel)
      
    @m_post.velocity = @m_post.velocity * 0.98 + accel * 0.02;
      
    if mMsecSinceStateChange > @aiWaypointDuration
      mStateChange(AISTATE_SEEK)
    end
      
    100
  end

  def mActByState
    callInterval = 100
    
    begin
      callInterval = case @aiState
        when AISTATE_IDLE : mStateChange(AISTATE_DORMANT)
        when AISTATE_DORMANT : mStateChange(AISTATE_SEEK)
        when AISTATE_SEEK : mStateActionSeek
        when AISTATE_WAYPOINT : mStateActionWaypoint
        else raise MushError.new("Bad aiState value @aiState") 
      end
    rescue
      mStateChange(AISTATE_IDLE)
      raise
    end
    callInterval
  end

end
