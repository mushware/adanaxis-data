#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziWarehouse.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.3, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 3umSoFeovs9HOTqwJkrQBQ
#
# $Id$
# $Log$
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziWarehouse < AdanaxisAIKhazi

  def mStateActionIdle
    mStateChangeDormant(60000)
  end

  def mStateActionDormantExit
    mStateChangeDormant(60000)
  end
  
  def mStateActionEvadeExit
    mStateChangePatrol(60000)
  end
  
  def mStateActionRamExit
    mStateChangePatrol(60000)
  end

  def mStateActionPatrolExit
    mStateChangePatrol(60000)
  end

  def mStateActionSeekExit
    mStateChangePatrol(60000)
  end

  def mStateActionWaypointExit
    mStateChangePatrol(60000)
  end

end
