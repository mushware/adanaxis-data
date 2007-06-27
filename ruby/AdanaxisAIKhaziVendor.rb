#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziVendor.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } BAzrLPaZn/enCynk0rHsyQ
#
# $Id: AdanaxisAIKhaziVendor.rb,v 1.1 2007/05/08 15:28:13 southa Exp $
# $Log: AdanaxisAIKhaziVendor.rb,v $
# Revision 1.1  2007/05/08 15:28:13  southa
# Level 12
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziVendor < AdanaxisAIKhazi

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
    if @r_piece.mWeapon.mAmmoCount == 0
      mStateChangeRam(60000)
    else
      mStateChangeEvade(3000)
    end
  end

  def mStateActionWaypointExit
    mStateChangeSeek(15000)
  end

end
