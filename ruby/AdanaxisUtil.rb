#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisUtil.rb
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
#%Header } 4LtYymInhExNdpOqSAaaUA
# $Id: AdanaxisUtil.rb,v 1.37 2007/06/14 18:55:10 southa Exp $
# $Log: AdanaxisUtil.rb,v $
# Revision 1.37  2007/06/14 18:55:10  southa
# Level and display tweaks
#
# Revision 1.36  2007/06/06 15:11:20  southa
# Level 23
#
# Revision 1.35  2007/06/05 12:15:14  southa
# Level 21
#
# Revision 1.34  2007/05/29 13:25:56  southa
# Level 20
#
# Revision 1.33  2007/05/21 13:32:52  southa
# Flush weapon
#
# Revision 1.32  2007/04/20 12:07:08  southa
# Khazi Warehouse and level 8
#
# Revision 1.31  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.30  2007/04/17 21:16:33  southa
# Level work
#
# Revision 1.29  2007/03/28 14:45:46  southa
# Level and AI standoff
#
# Revision 1.28  2007/03/27 14:01:03  southa
# Attendant AI
#
# Revision 1.27  2007/03/26 16:31:35  southa
# L2 work
#
# Revision 1.26  2007/03/24 18:07:23  southa
# Level 3 work
#
# Revision 1.25  2007/03/24 14:06:28  southa
# Cistern AI
#
# Revision 1.24  2007/03/23 18:39:08  southa
# Carriers and spawning
#
# Revision 1.23  2007/03/21 11:56:05  southa
# Rail effects and damage icons
#
# Revision 1.22  2007/03/20 20:36:55  southa
# Solid renderer fixes
#
# Revision 1.21  2007/03/13 18:21:36  southa
# Scanner jamming
#
# Revision 1.20  2007/03/13 12:22:50  southa
# Scanner symbols
#
# Revision 1.19  2007/03/09 11:29:12  southa
# Game end actions
#
# Revision 1.18  2007/03/07 16:59:43  southa
# Khazi spawning and level ends
#
# Revision 1.17  2007/03/07 11:29:23  southa
# Level permission
#
# Revision 1.16  2007/03/06 21:05:17  southa
# Level work
#
# Revision 1.15  2007/02/08 17:55:12  southa
# Common routines in space generation
#
# Revision 1.14  2006/11/17 20:08:34  southa
# Weapon change and ammo handling
#
# Revision 1.13  2006/11/15 18:25:54  southa
# Khazi rails
#
# Revision 1.12  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.11  2006/11/14 14:02:15  southa
# Ball projectiles
#
# Revision 1.10  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.9  2006/11/12 14:39:50  southa
# Player weapons amd audio fix
#
# Revision 1.8  2006/11/10 20:17:11  southa
# Audio work
#
# Revision 1.7  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.6  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.5  2006/11/01 13:04:21  southa
# Initial weapon handling
#
# Revision 1.4  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.3  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.2  2006/10/09 16:00:15  southa
# Intern generation
#
# Revision 1.1  2006/10/08 11:31:32  southa
# Hit points
#

require 'Mushware.rb'

class AdanaxisUtil < MushObject
  def self.cSpellCheck(inParams)
    inParams.each_key do |key|
      unless @c_symbols.has_key?(key)
        raise(RuntimeError, "Unknown symbol '#{key.to_s}' in parameter hash #{inParams.inspect}")
      end
    end
  end
  
  @c_symbols = {
    :acceleration => true,
    :ai_object => true,
    :ai_params => true,
    :ai_state => true,
    :ai_state_msec => true,
    :alpha_stutter => true,
    :ammo_count => true,
    :angular_position => true,
    :angular_velocity => true,
    :blue_count => true,
    :blue_total => true,
    :colour => true,
    :damage_frame => true,
    :deviation => true,
    :does_damage => true,
    :effect_scale => true,
    :embers => true,
    :ember_lifetime_range => true,
    :ember_scale_range => true,
    :ember_speed_range => true,
    :evade_acceleration => true,
    :evade_speed => true,
    :event => true,
    :explosions => true,
    :explosion_lifetime_range => true,
    :explosion_scale_range => true,
    :explosion_speed_range => true,
    :explo_number => true,
    :fire_rate_msec => true,
    :fire_sound => true,
    :flares => true,
    :flare_lifetime_range => true,
    :flare_scale_range => true,
    :flare_speed_range => true,
    :game_msec => true,
    :hit_points => true,
    :hit_point_ratio => true,
    :id_suffix => true,
    :is_battle => true,
    :is_flush => true,
    :is_jammer => true,
    :is_primary => true,
    :is_rocket => true,
    :is_stealth => true,
    :item_type => true,
    :jammable => true,
    :khazi_test => true,
    :load_sound => true,
    :lifetime_msec => true,
    :mesh_name => true,
    :num_projectiles => true,
    :offset_sequence => true,
    :override_dead_msec => true,
    :owner => true,
    :patrol_acceleration => true,
    :patrol_points => true,
    :patrol_speed => true,
    :position => true,
    :post => true,
    :primary => true,
    :projectile_mesh => true,
    :rail => true,
    :ram_acceleration => true,
    :ram_speed => true,
    :reload_sound => true,
    :red_count => true,
    :red_total => true,
    :remnant => true,
    :render_scale => true,
    :scanner_symbol => true,
    :seek_acceleration => true,
    :seek_speed => true,
    :seek_stand_off => true,
    :shield_ratio => true,
    :spawned => true,
    :spawn_inhibit_limit => true,
    :speed => true,
    :speed_limit => true,
    :target_id => true,
    :target_types => true,
    :type => true,
    :velocity => true,
    :velocity_factor => true,
    :vulnerability => true,
    :waypoint => true,
    :weapon => true,
    :weapon_name => true
    }
end

