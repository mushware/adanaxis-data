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
# $Id: AdanaxisRemnant.rb,v 1.6 2006/11/17 15:47:42 southa Exp $
# $Log: AdanaxisRemnant.rb,v $
# Revision 1.6  2006/11/17 15:47:42  southa
# Ammo remnants
#
# Revision 1.5  2006/11/17 13:22:06  southa
# Box textures
#
# Revision 1.4  2006/11/10 20:17:11  southa
# Audio work
#
# Revision 1.3  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.2  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.1  2006/10/30 17:03:50  southa
# Remnants creation
#

require 'AdanaxisUtil.rb'

class AdanaxisRemnant < MushObject
  def initialize
    @m_names = [
      :health1,
      :shield1,
      :player_base,
      :player_light_cannon,
      :player_quad_cannon,
      :player_flak,
      :player_heavy_cannon,
      :player_rail,
      :player_light_missile,
      :player_heavy_missile,
      :player_flush,
      :player_nuclear
      ]
    @remnantDefaults = {
      :lifetime_msec => 60000,
      :hit_points => 5.0
    }

    @m_healthDefaults = @remnantDefaults.merge(
      :mesh_name => "healthbox1"
    )

    @m_shieldDefaults = @remnantDefaults.merge(
      :mesh_name => "shieldbox1"
    )
    
    @m_ammoDefaults = @remnantDefaults
  end

  def mCreate(inParams)
    itemParams = {}
    itemType = inParams[:item_type]
    case itemType
      when :health1
        itemParams.merge!(@m_healthDefaults)
      when :shield1
        itemParams.merge!(@m_shieldDefaults)
      when :player_base
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'basebox1')        
      when :player_light_cannon
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'lightcannonbox1')        
      when :player_quad_cannon
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'quadcannonbox1')        
      when :player_flak
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'flakbox1')        
      when :player_heavy_cannon
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'heavycannonbox1')        
      when :player_rail
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'railbox1')        
      when :player_light_missile
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'lightmissilebox1')        
      when :player_heavy_missile
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'heavymissilebox1')        
      when :player_flush
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'flushbox1')        
      when :player_nuclear
        itemParams.merge!(@m_ammoDefaults)
        itemParams.merge!(:mesh_name => 'nuclearbox1')        
      else
        raise(RuntimeError, "Unknown remnant type '#{itemType || '(not set)'}'")
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
        MushGame.cSoundPlay("healthcollect1", inPiece.mPost)
      when :shield1
        inPiece.mLimitedShieldAdd(0.1) if inPiece.respond_to?(:mLimitedShieldAdd)
        MushGame.cSoundPlay("shieldcollect1", inPiece.mPost)
      when :player_base
        inPiece.mAmmoCollect(:player_base, 100) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load0", inPiece.mPost)
      when :player_light_cannon
        inPiece.mAmmoCollect(:player_light_cannon, 100) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load1", inPiece.mPost)
      when :player_quad_cannon
        inPiece.mAmmoCollect(:player_quad_cannon, 100) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load2", inPiece.mPost)
      when :player_flak
        inPiece.mAmmoCollect(:player_flak, 30) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load3", inPiece.mPost)
      when :player_heavy_cannon
        inPiece.mAmmoCollect(:player_heavy_cannon, 100) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load4", inPiece.mPost)
      when :player_rail
        inPiece.mAmmoCollect(:player_rail, 10) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load5", inPiece.mPost)
      when :player_light_missile
        inPiece.mAmmoCollect(:player_light_missile, 10) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load6", inPiece.mPost)
      when :player_heavy_missile
        inPiece.mAmmoCollect(:player_heavy_missile, 3) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load7", inPiece.mPost)
      when :player_flush
        inPiece.mAmmoCollect(:player_flush, 1) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load8", inPiece.mPost)
     when :player_nuclear
        inPiece.mAmmoCollect(:player_nuclear, 1) if inPiece.respond_to?(:mAmmoCollect)
        MushGame.cSoundPlay("load9", inPiece.mPost)
     else
        raise(RuntimeError, "Collected unknown remnant type '#{inItem.inspect}'")
     end
  end

  def mStandardRemnant(inSequenceNum)
    retVal = nil
    
    if inSequenceNum == 0
      # No remnant
    elsif inSequenceNum % 8 == 0
      retVal = :shield1
    elsif inSequenceNum % 4 == 0
      retVal = :health1
    end
    retVal = @m_names[rand(@m_names.size)]
    retVal
  end
end
