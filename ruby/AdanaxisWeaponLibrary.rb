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
# $Id: AdanaxisWeaponLibrary.rb,v 1.3 2006/11/03 18:46:32 southa Exp $
# $Log: AdanaxisWeaponLibrary.rb,v $
# Revision 1.3  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.2  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.1  2006/11/01 13:04:21  southa
# Initial weapon handling
#
#

require 'AdanaxisWeapon.rb'

class AdanaxisWeaponLibrary < MushObject
  def initialize(inParams = {})
    @m_weapons = {}
  end
  
  def mCreate
    @m_weapons[:player_base] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 2.0,
      :fire_rate_msec => 50,
      :offset_sequence => [
        MushVector.new(-1,0,0,0),
        MushVector.new(1,0,0,0)
      ],
      :fire_sound => 'fire'
    )
    
    @m_weapons[:player_super_nuker] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile2',
      :speed => 1.0,
      :fire_rate_msec => 2000,
      :lifetime_msec => 5000,
      :offset_sequence => [
        MushVector.new(0,-2,0,0)
      ],
      :hit_points => 500.0,
      :fire_sound => 'fire'
    )

    @m_weapons[:khazi_base] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 1.0,
      :fire_rate_msec => 3000
    )
  end
  
  def mWeapon(inName)
    return @m_weapons[inName.to_sym].dup
  end
end
