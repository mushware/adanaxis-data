#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisTriggeredEvent.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.2, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 4dJjdxywEhuBTi8pjksarw
 #
 # $Id$
 # $Log$
 
class AdanaxisTriggeredEvent < MushObject

  def initialize(inParams = {})
    AdanaxisUtil::cSpellCheck(inParams)
    @m_gameMsec = inParams[:game_msec]
    @m_khaziTest = inParams[:khazi_test]
    @m_event = inParams[:event] || nil
  end
  
  mush_accessor :m_gameMsec, :m_khaziTest, :m_event
end
