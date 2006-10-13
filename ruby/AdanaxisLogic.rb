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
# $Id: AdanaxisLogic.rb,v 1.5 2006/10/12 22:04:46 southa Exp $
# $Log: AdanaxisLogic.rb,v $
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

class AdanaxisLogic < MushLogic

  def initialize
    @m_outbox = []
  end

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
    # Send each object with itself in the first position
    event.m_piece1.mLoad
    event.m_piece2.mLoad
    
    event.m_piece1.mEventHandle(event)
    
    # Swap piece1 and piece2 in the event
    event.mPiecesSwap!
    
    event.m_piece1.mEventHandle(event)
  end
end
