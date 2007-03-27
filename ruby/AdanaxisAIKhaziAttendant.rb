#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziAttendant.rb
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
#%Header } 6UJyFE/GwtfMJb35bHRd3w
#
# $Id$
# $Log$

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziAttendant < AdanaxisAIKhazi

  def mStateActionIdle
    mStateChangeSeek(15000)
  end

  def mStateActionEvadeExit
    mStateChangeSeek(15000)
  end
  
  def mStateActionRamExit
    mStateChangeEvade(3000)
  end

  def mStateActionPatrolExit
    mStateChangeSeek(15000)
  end

  def mStateActionSeekExit
    mStateChangeEvade(4000)
  end

  def mStateActionWaypointExit
    mStateChangeSeek(15000)
  end

end
