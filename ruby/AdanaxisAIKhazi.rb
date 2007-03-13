#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhazi.rb
#
# Copyright Andy Southgate 2006-2007
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
#%Header } vFcFUi6Q6o5UJz/4xLaADw
# $Id: AdanaxisAIKhazi.rb,v 1.1 2006/09/30 13:46:32 southa Exp $
# $Log: AdanaxisAIKhazi.rb,v $
# Revision 1.1  2006/09/30 13:46:32  southa
# Seek and patrol
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'

class AdanaxisAIKhazi < AdanaxisAI

  def mActMain
    case @m_state
      when AISTATE_WAYPOINT : callInterval = mStateActionWaypoint
      else callInterval = super 
    end

    callInterval
  end

end
