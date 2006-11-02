#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisEvents.rb
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
#%Header } fAZMXASsvVkN8FSXXDhczg
# $Id: AdanaxisEvents.rb,v 1.3 2006/10/09 16:00:15 southa Exp $
# $Log: AdanaxisEvents.rb,v $
# Revision 1.3  2006/10/09 16:00:15  southa
# Intern generation
#
# Revision 1.2  2006/08/25 01:44:56  southa
# Khazi fire
#
# Revision 1.1  2006/08/24 13:04:37  southa
# Event handling
#

class AdanaxisEventFire < MushEvent
  def initialize
    @m_post = MushPost.new
  end
  
  mush_accessor :m_post
end
