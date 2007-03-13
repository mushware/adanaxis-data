#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisMagazine.rb
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
#%Header } GPHu2Py9IcyCt6EJcemnkw
# $Id: AdanaxisMagazine.rb,v 1.1 2006/11/17 20:08:34 southa Exp $
# $Log: AdanaxisMagazine.rb,v $
# Revision 1.1  2006/11/17 20:08:34  southa
# Weapon change and ammo handling
#

class AdanaxisMagazine < MushObject

  def initialize(inParams = {})
    @m_count = {}
    @m_count[:player_base] = 100
    @m_count[:player_light_cannon] = 0
    @m_count[:player_flak] = 0
    @m_count[:player_quad_cannon] = 0
    @m_count[:player_rail] = 0
    @m_count[:player_heavy_cannon] = 0
    @m_count[:player_light_missile] = 0
    @m_count[:player_heavy_missile] = 0
    @m_count[:player_flush] = 0
    @m_count[:player_nuclear] = 0
    @m_limit = {}
    @m_limit[:player_base] = 800
    @m_limit[:player_light_cannon] = 200
    @m_limit[:player_flak] = 100
    @m_limit[:player_quad_cannon] = 800
    @m_limit[:player_rail] = 100
    @m_limit[:player_heavy_cannon] = 800
    @m_limit[:player_light_missile] = 50
    @m_limit[:player_heavy_missile] = 50
    @m_limit[:player_flush] = 10
    @m_limit[:player_nuclear] = 10
  end
  
  def mPlayerLoadAll
    @m_count[:player_base] = 800
    @m_count[:player_light_cannon] = 200
    @m_count[:player_flak] = 50
    @m_count[:player_quad_cannon] = 800
    @m_count[:player_rail] = 30
    @m_count[:player_heavy_cannon] = 200
    @m_count[:player_light_missile] = 30
    @m_count[:player_heavy_missile] = 10
    @m_count[:player_flush] = 3
    @m_count[:player_nuclear] = 3
  end

  def mAmmoAvailable(inType)
    return @m_count[inType] > 0
  end
  
  def mAmmoDecrement(inType)
    @m_count[inType] -= 1
    nil
  end
  
  def mAmmoCount(inType)
    @m_count[inType]
  end
  
  def mLimitedAmmoAdd(inType, inNumber)
    @m_count[inType] += inNumber
    @m_count[inType] = @m_limit[inType] if @m_count[inType] > @m_limit[inType]
  end
end
