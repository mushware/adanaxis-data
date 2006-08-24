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
# $Id: AdanaxisLogic.rb,v 1.1 2006/08/24 13:04:37 southa Exp $
# $Log: AdanaxisLogic.rb,v $
# Revision 1.1  2006/08/24 13:04:37  southa
# Event handling
#

class AdanaxisLogic < MushLogic

  def initialize
    @m_outbox = []
  end

  def mLookup(id)
    case id
      when /^k/
        receiver = AdanaxisPieceKhazi.cLookup(id[1..-1])
      else
        raise MushError.new("Cannot decode object id '#{id}'")
    end
    receiver
  end

  def mInboxConsume(inbox)
    inbox.each do |event|
      begin
        receiver = mLookup(event.dest)
        receiver.mEventHandle(event)
      rescue Exception => e
        MushLog.cWarn "Event failed: #{e} at #{e.backtrace[0]}"
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
end
