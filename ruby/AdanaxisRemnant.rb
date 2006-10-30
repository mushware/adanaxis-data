#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisRemnant.rb
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
#%Header } bWqJ8Rs4225yq5McUizgaw
# $Id$
# $Log$

require 'AdanaxisUtil.rb'

class AdanaxisRemnant < MushObject
  def initialize
    @remnantDefaults = {
      :lifetime_msec => 60000,
      :hit_points => 5.0
    }

  
    @m_healthDefaults = @remnantDefaults.merge(
      :mesh_name => "health1"
    )

    @m_shieldDefaults = @remnantDefaults.merge(
      :mesh_name => "shield1"
    )
  end

  def mCreate(inParams)
    itemParams = {}
    
    case inParams[:type]
      when :health1
        itemParams.merge!(@m_healthDefaults)
      when :shield1
        itemParams.merge!(@m_shieldDefaults)
      else
        raise(RuntimeError, "Unknown remnant type '#{inParams[:type] || '(not set)'}'")
    end
    itemParams.merge!(inParams)
 
    velocityFactor = itemParams[:velocity_factor] || 0.0
 
    itemParams[:post] = MushPost.new(
      :position => itemParams[:post].position,
      :velocity => itemParams[:post].velocity * velocityFactor,
      :angular_velocity => MushTools.cRandomAngularVelocity(0.01)
    )
    
    AdanaxisUtil.cSpellCheck(inParams)
    
    AdanaxisPieceItem.cCreate(itemParams)
  end
  
  def self.cStandardRemnant(inSequenceNum)
    retVal = nil
    
    if inSequenceNum == 0
      # No remnant
    elsif inSequenceNum % 20 == 0
      retVal = :shield1
    elsif inSequenceNum % 5 == 0
      retVal = :health1
    end
    retVal
  end
end
