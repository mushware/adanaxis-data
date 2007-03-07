#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisUtil.rb
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
#%Header } 63kk9LVPAcoFqUyUUPiQfg
# $Id: AdanaxisUtil.rb,v 1.17 2007/03/07 11:29:23 southa Exp $
# $Log: AdanaxisUtil.rb,v $
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
    :ai_params => true,
    :ai_state => true,
    :ammo_count => true,
    :angular_position => true,
    :angular_velocity => true,
    :colour => true,
    :damage_frame => true,
    :deviation => true,
    :does_damage => true,
    :embers => true,
    :ember_lifetime_range => true,
    :ember_scale_range => true,
    :ember_speed_range => true,
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
    :hit_points => true,
    :hit_point_ratio => true,
    :id_suffix => true,
    :item_type => true,
    :load_sound => true,
    :lifetime_msec => true,
    :mesh_name => true,
    :num_projectiles => true,
    :offset_sequence => true,
    :owner => true,
    :patrol_acceleration => true,
    :patrol_speed => true,
    :position => true,
    :post => true,
    :projectile_mesh => true,
    :reload_sound => true,
    :rail => true,
    :remnant => true,
    :render_scale => true,
    :seek_acceleration => true,
    :seek_speed => true,
    :shield_ratio => true,
    :speed => true,
    :speed_limit => true,
    :target_types => true,
    :type => true,
    :velocity => true,
    :velocity_factor => true,
    :vulnerability => true,
    :waypoint => true,
    :waypoint_msec => true,
    :weapon => true,
    :weapon_name => true
    }
end

