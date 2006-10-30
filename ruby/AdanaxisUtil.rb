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
# $Id: AdanaxisUtil.rb,v 1.3 2006/10/30 17:03:50 southa Exp $
# $Log: AdanaxisUtil.rb,v $
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
    :angular_position => true,
    :angular_velocity => true,
    :does_damage => true,
    :embers => true,
    :ember_lifetime_range => true,
    :ember_scale_range => true,
    :ember_speed_range => true,
    :explosions => true,
    :explosion_scale_range => true,
    :explosion_speed_range => true,
    :flares => true,
    :flare_lifetime_range => true,
    :flare_scale_range => true,
    :flare_speed_range => true,
    :hit_points => true,
    :id_suffix => true,
    :item_type => true,
    :lifetime_msec => true,
    :mesh_name => true,
    :owner => true,
    :position => true,
    :post => true,
    :remnant => true,
    :render_scale => true,
    :seek_acceleration => true,
    :seek_speed => true,
    :target_types => true,
    :type => true,
    :velocity => true,
    :velocity_factor => true
    }
end

