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
# $Id: AdanaxisPieceKhazi.rb,v 1.9 2006/09/29 10:47:56 southa Exp $
# $Log: AdanaxisPieceKhazi.rb,v $
# Revision 1.9  2006/09/29 10:47:56  southa
# Object AI
#
# Revision 1.8  2006/08/25 11:06:07  southa
# Snapshot
#
# Revision 1.7  2006/08/25 01:44:56  southa
# Khazi fire
#
# Revision 1.6  2006/08/24 16:30:55  southa
# Event handling
#
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
require 'AdanaxisAIKhazi.rb'
require 'AdanaxisEvents.rb'

class AdanaxisPieceKhazi < MushPiece
  extend MushRegistered
  mushRegistered_install
  
  def initialize
    super
    @m_callInterval = 100
    @numTimes = rand(30)
    @m_ai = AdanaxisAIKhazi.new
  end
  
  def mTimerHandle(event)
    puts "Timer event"
    mLoad
  end
  
  def mFireHandle(event)
    projPost = event.post.dup
    
    vel = MushVector.new(0,0,0,-1)
    
    projPost.angular_position.mRotate(vel)
    
    projPost.velocity = projPost.velocity + vel
    projPost.angular_velocity = MushRotation.new
    
    khazi = AdanaxisPieceProjectile.cCreate(
      :mesh_name => "projectile",
      :post => projPost,
      :owner => m_id,
      :lifetime_msec => 15000
    )
  end

  def mEventHandle(event)
    case event
      when MushEventTimer: mTimerHandle(event)
      when AdanaxisEventFire: mFireHandle(event)
      else super(event)
    end
    @m_callInterval
  end

  def mActionTimer
    mLoad

    @m_callInterval = @m_ai.mActByState(self)

    @numTimes += 1
    mFire if (@numTimes % 30) == 0

    mSave
    
    $currentLogic.mReceiveSequence
    
    @m_callInterval
  end

  def mFire
    event = AdanaxisEventFire.new
    event.post = @m_post
    $currentLogic.mEventConsume(event, @m_id, @m_id)  
  end
end
