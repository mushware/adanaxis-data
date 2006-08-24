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
# $Id$
# $Log$

class AdanaxisLogic < MushLogic
  def mLookup(id)
    case id
      when /^k/
        receiver = AdanaxisPieceKhazi.cLookup(id[1..-1])
      else
        raise TypeError.new("Cannot decode object id '#{id}'")
    end
    receiver
  end

  def mEventConsume(event, src, dest)
    puts "Consuming event #{event.inspect} from #{src} to #{dest}"
    begin
      receiver = mLookup(dest)
      puts "Receiver is #{receiver.inspect}"
    rescue Exception => e
      puts "Discarding event: #{e}"
    end
  end
end
