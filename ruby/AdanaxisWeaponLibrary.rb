#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisWeaponLibrary.rb
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
#%Header } fqw0Kg8SFKBRqHTmFMXeGw
# $Id$
# $Log$
#

require 'AdanaxisWeapon.rb'

class AdanaxisWeaponLibrary < MushObject
  def initialize(inParams = {})
    @m_weapons = {}
  end
  
  def mCreate
    @m_weapons[:base] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile'
    )
    
    @m_weapons[:khazi_base] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile',
      :speed => 1.0,
      :fire_rate_msec => 3000
    )
  end
  
  def mWeapon(inName)
    return @m_weapons[inName.to_sym].dup
  end
end
