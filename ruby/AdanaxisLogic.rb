#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisLogic.rb
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
#%Header } OEQ7ye4+ICpoJw+Z14qbnQ
# $Id: AdanaxisLogic.rb,v 1.12 2006/10/30 19:36:38 southa Exp $
# $Log: AdanaxisLogic.rb,v $
# Revision 1.12  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.11  2006/10/30 17:03:49  southa
# Remnants creation
#
# Revision 1.10  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.9  2006/10/16 14:36:50  southa
# Deco handling
#
# Revision 1.8  2006/10/15 17:12:53  southa
# Scripted explosions
#
# Revision 1.7  2006/10/14 16:59:43  southa
# Ruby Deco objects
#
# Revision 1.6  2006/10/13 14:21:25  southa
# Collision handling
#
# Revision 1.5  2006/10/12 22:04:46  southa
# Collision events
#
# Revision 1.4  2006/10/02 20:28:09  southa
# Object lookup and target selection
#
# Revision 1.3  2006/08/25 01:44:56  southa
# Khazi fire
#
# Revision 1.2  2006/08/24 16:30:55  southa
# Event handling
#
# Revision 1.1  2006/08/24 13:04:37  southa
# Event handling
#

require 'AdanaxisEffects.rb'
require 'AdanaxisRemnant.rb'

class AdanaxisLogic < MushLogic

  def initialize
    @m_outbox = []
    @m_effects = AdanaxisEffects.new
    @m_remnant = AdanaxisRemnant.new
  end

  mush_reader :m_effects, :m_remnant, :m_view

  def mLookup(id)
    # Only pieces for the moment
    return MushGame.cPieceLookup(id)
  end

  def mInboxConsume(inbox)
    inbox.each do |event|
      begin
        receiver = mLookup(event.dest)
        receiver.mEventHandle(event)
      rescue Exception => e
        MushLog.cWarning "Event failed: #{e} at #{e.backtrace[0]}"
      end
    end
    inbox.clear
  end

  def mEventConsume(event, src, dest)
    event.src = src
    event.dest = dest
    @m_outbox << event
  end
  
  def mReceiveSequence
    mInboxConsume(@m_outbox)
  end
  
  def mCollisionEventConsume(event)
    event.mPiece1.mLoad
    event.mPiece2.mLoad
    
    # Decrement hit points here, otherwise one object will used the already-
    # decremented value of the other
    
    hitPoints1 = event.mPiece1.mHitPoints
    hitPoints2 = event.mPiece2.mHitPoints
    
    event.mPiece1.mDamageTake(hitPoints2 * event.mPiece2.mDamageFactor)
    event.mPiece2.mDamageTake(hitPoints1 * event.mPiece1.mDamageFactor)
    
    # Send to each object with itself in the first position
    event.mPiece1.mEventHandle(event)
    
    # Swap piece1 and piece2 in the event
    event.mPiecesSwap!
    
    event.mPiece1.mEventHandle(event)
    
    event.mPiece1.mSave
    event.mPiece2.mSave
  end
end
