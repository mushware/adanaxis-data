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
# $Id: AdanaxisRemnant.rb,v 1.2 2006/10/30 19:36:38 southa Exp $
# $Log: AdanaxisRemnant.rb,v $
# Revision 1.2  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.1  2006/10/30 17:03:50  southa
# Remnants creation
#

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
    
    case inParams[:item_type]
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
    
    AdanaxisPieceItem.cCreate(itemParams)
  end
  
  def mCollect(inItem, inPiece)
    case inItem.mItemType
      when :health1
        inPiece.mLimitedHealthAdd(0.1) if inPiece.respond_to?(:mLimitedHealthAdd)
      when :shield1
        inPiece.mLimitedShieldAdd(0.1) if inPiece.respond_to?(:mLimitedShieldAdd)
      else
        raise(RuntimeError, "Collected unknown remnant type '#{inItem.inspect}'")
      end
  end

  def self.cStandardRemnant(inSequenceNum)
    retVal = nil
    
    if inSequenceNum == 0
      # No remnant
    elsif inSequenceNum % 8 == 0
      retVal = :shield1
    elsif inSequenceNum % 4 == 0
      retVal = :health1
    end
    retVal
  end
end
