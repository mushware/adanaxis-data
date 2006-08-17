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
# $Id: AdanaxisPieceKhazi.rb,v 1.1 2006/08/17 08:57:10 southa Exp $
# $Log: AdanaxisPieceKhazi.rb,v $
# Revision 1.1  2006/08/17 08:57:10  southa
# Event handling
#

require 'Mushware.rb'

class AdanaxisPieceKhazi < MushPiece
  extend MushRegistered
  mushRegistered_install
  
  def mInitialise
    @callInterval = 1000
    @numTimes = 0
    @post = MushPost.new

    return @callInterval
  end
  
  def mLoad
    mPostLoad(@post)
    puts "Retrieved post #{@post}"
  end
  
  def mSave
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

  def mActionTimer
    puts "Action time"
    mLoad
    @numTimes += 1
    (@numTimes < 10) ? @callInterval : nil
  end

  def mBanner
    puts "Hello from object"
    puts @@registeredObjects
    
    event = MushEventTimer.new
    mHandle(event)
  end
end
