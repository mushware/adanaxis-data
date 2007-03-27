#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisWeaponLibrary.rb
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
#%Header } KYgLHF8t3YCZa/IBjNku9Q
# $Id: AdanaxisWeaponLibrary.rb,v 1.19 2007/03/26 16:31:35 southa Exp $
# $Log: AdanaxisWeaponLibrary.rb,v $
# Revision 1.19  2007/03/26 16:31:35  southa
# L2 work
#
# Revision 1.18  2007/03/24 18:07:23  southa
# Level 3 work
#
# Revision 1.17  2007/03/23 18:39:08  southa
# Carriers and spawning
#
# Revision 1.16  2007/03/23 12:27:34  southa
# Added levels and Cistern mesh
#
# Revision 1.15  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.14  2007/03/06 21:05:17  southa
# Level work
#
# Revision 1.13  2006/12/14 15:59:23  southa
# Fire and cutscene fixes
#
# Revision 1.12  2006/11/17 15:47:42  southa
# Ammo remnants
#
# Revision 1.11  2006/11/15 19:26:02  southa
# Rail changes
#
# Revision 1.10  2006/11/15 18:25:54  southa
# Khazi rails
#
# Revision 1.9  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.8  2006/11/14 14:02:16  southa
# Ball projectiles
#
# Revision 1.7  2006/11/12 20:09:54  southa
# Missile guidance
#
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
    case AdanaxisRuby.cGameDifficulty
    when 0
      aiParams = {:seek_acceleration => 0.01}
    when 1
      aiParams = {:seek_acceleration => 0.005}
    end
    
    @m_weapons[:player_base] = AdanaxisWeapon.new(
      :projectile_mesh => 'ball1',
      :speed => 1.0,
      :hit_points => 1.0,
      :fire_rate_msec => 200,
      :offset_sequence => [
        MushVector.new(0,-0.5,0,0)
      ],
      :load_sound => 'load0',
      :fire_sound => 'fire0',
      :ai_params => aiParams,
      :angular_velocity => MushRotation.new
    )

    @m_weapons[:player_light_cannon] = AdanaxisWeapon.new(
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
      :projectile_mesh => 'ball1',
      :speed => 2.0,
      :hit_points => 2.0,
      :fire_rate_msec => 500,
      :lifetime_msec => 700..1000,
      :offset_sequence => [
        MushVector.new(0,-0.5,0,0)
      ],
      :num_projectiles => 10,
      :deviation => 0.1,
      :load_sound => 'load2',
      :fire_sound => 'fire2',
      :ai_params => aiParams,
      :angular_velocity => MushRotation.new
    )
    @m_weapons[:player_quad_cannon] = AdanaxisWeapon.new(
      :projectile_mesh => 'projectile1',
      :speed => 2.0,
      :hit_points => 1.0,
      :fire_rate_msec => 50,
      :offset_sequence => [
        MushVector.new(-1,-0.5,0,0),
        MushVector.new(1,0.5,0,0),
        MushVector.new(-1,0.5,0,0),
        MushVector.new(1,-0.5,0,0)
      ],
      :load_sound => 'load3',
      :fire_sound => 'fire3'
    )
    
    railAngVel = MushTools.cRotationInXYPlane(0.04)
    MushTools.cRotationInXZPlane(0.1).mRotate(railAngVel)
    MushTools.cRotationInYZPlane(0.14).mRotate(railAngVel)

    @m_weapons[:player_rail] = AdanaxisWeapon.new(
      :projectile_mesh => 'rail1',
      :type => :rail,
      :angular_velocity => railAngVel,
      :hit_points => 50.0,
      :fire_rate_msec => 2000,
      :lifetime_msec => 500,
      :offset_sequence => [
        MushVector.new(0,-0.5,0,0)
      ],
      :load_sound => 'load4',
      :reload_sound => 'load4',
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
      :type => :rocket,
      :projectile_mesh => 'projectile1',
      :speed => 0.0,
      :acceleration => 0.01,
      :speed_limit => 4.0,
      :hit_points => 15.0,
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
      :type => :rocket,
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
    @m_weapons[:player_flush] = AdanaxisWeapon.new(
      :type => :rocket,
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
      :projectile_mesh => 'ball1',
      :lifetime_msec => 5000,
      :speed => 0.5,
      :fire_rate_msec => 3000
    )
    @m_weapons[:khazi_rail] = AdanaxisWeapon.new(
      :projectile_mesh => 'rail1',
      :hit_points => 40,
      :type => :rail,
      :lifetime_msec => 300,
      :offset_sequence => [
        MushVector.new(0,0,0,-6.0)
      ],
      :fire_rate_msec => 5000,
      :fire_sound => 'fire6'
    )

    @m_weapons[:attendant_spawner] = AdanaxisWeapon.new(
      :type => :spawner,
      :ammo_count => 1,
      :speed => -0.2,
      :offset_sequence => [
        MushVector.new(0,0,0,15.0)
      ],
      :fire_rate_msec => 3000,
      :fire_sound => 'fire9'
    )

  end
  
  def mWeapon(inName)
    if inName
      retVal = @m_weapons[inName.to_sym].dup
    else
      retVal = nil
    end
    retVal
  end
end
