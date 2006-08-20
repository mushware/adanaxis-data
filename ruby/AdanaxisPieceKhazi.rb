#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceKhazi.rb
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
#%Header } aGTJVbl7QyXIWVg5D1mEzg
# $Id: AdanaxisPieceKhazi.rb,v 1.3 2006/08/19 09:12:09 southa Exp $
# $Log: AdanaxisPieceKhazi.rb,v $
# Revision 1.3  2006/08/19 09:12:09  southa
# Event handling
#
# Revision 1.2  2006/08/17 12:18:10  southa
# Event handling
#
# Revision 1.1  2006/08/17 08:57:10  southa
# Event handling
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'

class AdanaxisPieceKhazi < MushPiece
  extend MushRegistered
  mushRegistered_install
  
  include AdanaxisAI
  
  def mInitialise
    @callInterval = 100
    @numTimes = 0
    @aiState = AISTATE_DORMANT
    return @callInterval
  end
  
  def mTimerHandle(event)
    puts "Timer event"
    mLoad
  end
  
  def mHandle(event)
    case event
      when MushEventTimer: mTimerHandle(event)
      else super(event)
    end
    @callInterval
  end

  def mStateActionSeek
    angVel = MushTools::cSlerp(@m_post.angular_velocity,
      MushTools.cTurnToFace(@m_post, AdanaxisRuby.cPlayerPosition, 0.05),
      0.2)
      
    angVel.mScale!(0.5)
    
    @m_post.angular_velocity = angVel
      
    @callInterval = 100
  end

  def mActByState
    case @aiState
      when AISTATE_IDLE : @aiState = AISTATE_DORMANT
      when AISTATE_DORMANT : @aiState = AISTATE_SEEK
      when AISTATE_SEEK : mStateActionSeek  
    end
  end

  def mActionTimer
    mLoad

    mActByState

    mSave
    @numTimes += 1
    
    
    @callInterval
  end

  def mBanner
    puts "Hello from object"
    puts @@registeredObjects
    
    event = MushEventTimer.new
    mHandle(event)
  end
end
