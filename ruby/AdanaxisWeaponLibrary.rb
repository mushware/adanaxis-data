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
# $Id: AdanaxisWeaponLibrary.rb,v 1.6 2006/11/12 14:39:50 southa Exp $
# $Log: AdanaxisWeaponLibrary.rb,v $
# Revision 1.6  2006/11/12 14:39:50  southa
# Player weapons amd audio fix
#
# Revision 1.5  2006/11/10 20:17:11  southa
# Audio work
#
# Revision 1.4  2006/11/05 09:32:13  southa
# Mush file generation
#
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
    @m_weapons[:player_light_machine] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 1.0,
      :hit_points => 1.0,
      :fire_rate_msec => 200,
      :offset_sequence => [
        MushVector.new(0,-0.5,0,0)
      ],
      :load_sound => 'load0',
      :fire_sound => 'fire0',
      :ai_params => {:seek_acceleration => 0.01},
      :angular_velocity => MushRotation.new
    )

    @m_weapons[:player_fast_machine] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 2.0,
      :hit_points => 1.0,
      :fire_rate_msec => 100,
      :offset_sequence => [
        MushVector.new(-1,0,0,0),
        MushVector.new(1,0,0,0)
      ],
      :load_sound => 'load1',
      :fire_sound => 'fire1'
    )
    @m_weapons[:player_flak] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 2.0,
      :hit_points => 1.0,
      :fire_rate_msec => 500,
      :lifetime_msec => 1000,
      :offset_sequence => [
        MushVector.new(0,-0.5,0,0)
      ],
      :load_sound => 'load2',
      :fire_sound => 'fire2'
    )
    @m_weapons[:player_quad_machine] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 2.0,
      :hit_points => 1.0,
      :fire_rate_msec => 100,
      :offset_sequence => [
        MushVector.new(-1,-0.5,0,0),
        MushVector.new(1,0.5,0,0),
        MushVector.new(-1,0.5,0,0),
        MushVector.new(1,-0.5,0,0)
      ],
      :load_sound => 'load3',
      :fire_sound => 'fire3'
    )
    @m_weapons[:player_rail_gun] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 2.0,
      :hit_points => 50.0,
      :fire_rate_msec => 1000,
      :offset_sequence => [
        MushVector.new(0,-0.5,0,0)
      ],
      :load_sound => 'load4',
      :fire_sound => 'fire4'
    )
    @m_weapons[:player_heavy_cannon] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 2.0,
      :hit_points => 4.0,
      :fire_rate_msec => 100,
      :offset_sequence => [
        MushVector.new(-1,0,0,0),
        MushVector.new(1,0,0,0)
      ],
      :load_sound => 'load5',
      :fire_sound => 'fire5'
    )
    @m_weapons[:player_light_missile] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 0.0,
      :acceleration => 0.01,
      :speed_limit => 4.0,
      :hit_points => 25.0,
      :fire_rate_msec => 400,
      :lifetime_msec => 6000,
      :offset_sequence => [
        MushVector.new(-1,-0.3,0,0),
        MushVector.new(1,-0.3,0,0)
      ],
      :load_sound => 'load6',
      :fire_sound => 'fire6',
      :reload_sound => 'load6',
      :ai_params => {:seek_acceleration => 0.01},
      :angular_velocity => MushRotation.new
    )
    @m_weapons[:player_heavy_missile] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 0.0,
      :acceleration => 0.005,
      :speed_limit => 4.0,
      :hit_points => 80.0,
      :fire_rate_msec => 1000,
      :lifetime_msec => 20000,
      :offset_sequence => [
        MushVector.new(-0.8,-0.3,0,0),
        MushVector.new(0.8,-0.3,0,0)
      ],
      :load_sound => 'load7',
      :fire_sound => 'fire7',
      :reload_sound => 'load7',
      :ai_params => {:seek_acceleration => 0.02},
      :angular_velocity => MushRotation.new
    )
    @m_weapons[:player_flush_gun] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 0.0,
      :acceleration => 0.005,
      :speed_limit => 0.5,
      :hit_points => 0.0,
      :fire_rate_msec => 2000,
      :lifetime_msec => 6000,
      :offset_sequence => [
        MushVector.new(0,-0.5,0,0)
      ],
      :load_sound => 'load8',
      :fire_sound => 'fire8'
    )
    
    @m_weapons[:player_nuclear] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile2',
      :speed => 1.0,
      :hit_points => 500.0,
      :fire_rate_msec => 10000,
      :lifetime_msec => 5000,
      :offset_sequence => [
        MushVector.new(0,-1,0,0)
      ],
      :load_sound => 'load9',
      :fire_sound => 'fire9'
    )

    @m_weapons[:khazi_base] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 0.5,
      :fire_rate_msec => 3000
    )
  end
  
  def mWeapon(inName)
    return @m_weapons[inName.to_sym].dup
  end
end
