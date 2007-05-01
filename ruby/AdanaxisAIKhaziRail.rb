#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziRail.rb
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
#%Header } KquJ2LoaPKky37EvVhjtXQ
# $Id: AdanaxisAIKhaziRail.rb,v 1.2 2007/04/18 09:21:51 southa Exp $
# $Log: AdanaxisAIKhaziRail.rb,v $
# Revision 1.2  2007/04/18 09:21:51  southa
# Header and level fixes
#
# Revision 1.1  2007/04/17 21:16:33  southa
# Level work
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziRail < AdanaxisAIKhazi

  def mStateActionIdle
    mStateChangeSeek(40000)
  end

  def mStateActionDormantExit
    mStateChangeSeek(40000)
  end
  
  def mStateActionEvadeExit
    mTargetSelect # Always reselect target
    mStateChangeSeek(40000)
  end
  
  def mStateActionRamExit
    mStateChangeEvade(20000)
  end

  def mStateActionPatrolExit
    mStateChangeSeek(40000)
  end

  def mStateActionSeekExit
    mStateChangeEvade(20000)
  end

  def mStateActionWaypointExit
    mStateChangeSeek(40000)
  end

end
