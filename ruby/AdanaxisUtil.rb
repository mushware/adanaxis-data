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
# $Id: AdanaxisUtil.rb,v 1.1 2006/10/08 11:31:32 southa Exp $
# $Log: AdanaxisUtil.rb,v $
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
    :hit_points => true,
    :id_suffix => true,
    :mesh_name => true,
    :position => true,
    :post => true,
    :seek_acceleration => true,
    :seek_speed => true,
    :target_types => true,
    :type => true,
    :velocity => true
    }
end
