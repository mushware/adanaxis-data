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
# $Id: AdanaxisPieceKhazi.rb,v 1.5 2006/08/24 13:04:37 southa Exp $
# $Log: AdanaxisPieceKhazi.rb,v $
# Revision 1.5  2006/08/24 13:04:37  southa
# Event handling
#
# Revision 1.4  2006/08/20 14:19:20  southa
# Seek operation
#
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
require 'AdanaxisEvents.rb'

class AdanaxisPieceKhazi < MushPiece
  extend MushRegistered
  mushRegistered_install
  
  include AdanaxisAI
  
  def initialize
    super
    @callInterval = 100
    @numTimes = 0
    @aiState = AISTATE_DORMANT
  end
  
  def mTimerHandle(event)
    puts "Timer event"
    mLoad
  end
  
  def mFireHandle(event)
    puts "Fire event #{event.inspect}"
  end

  def mEventHandle(event)
    case event
      when MushEventTimer: mTimerHandle(event)
      when AdanaxisEventFire: mFireHandle(event)
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

    @numTimes += 1
    mFire if (@numTimes % 10) == 0

    mSave
    
    $currentLogic.mReceiveSequence
    
    @callInterval
  end

  def mFire
    event = AdanaxisEventFire.new
    event.m_post = @m_post
    $currentLogic.mEventConsume(event, @m_id, @m_id)  
  end

  def mBanner
    puts "Hello from object"
    puts @@registeredObjects
    
    event = MushEventTimer.new
    mHandle(event)
  end
end
