#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisEffects.rb
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
#%Header } mnNwuBeOv7iId5VtLmVtTA
# $Id: AdanaxisEffects.rb,v 1.5 2006/11/09 23:53:59 southa Exp $
# $Log: AdanaxisEffects.rb,v $
# Revision 1.5  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.4  2006/10/16 22:00:20  southa
# Tweaks
#
# Revision 1.3  2006/10/16 15:25:57  southa
# Explosion lifetimes
#
# Revision 1.2  2006/10/16 14:36:50  southa
# Deco handling
#
# Revision 1.1  2006/10/15 17:12:53  southa
# Scripted explosions
#

class AdanaxisEffects < MushObject
  def initialize
    @m_numEmberMeshes = 10
    @m_numExploMeshes = 8
    @m_numFlareMeshes = 10
    
    @m_emberDefaults = {
      :lifetime_msec => 1000,
      :ember_speed_range => (0.1..0.4),
      :ember_scale_range => (0.1..0.4)
      }

    @m_exploDefaults = {
      :lifetime_msec => 2000,
      :explosion_scale_range => (2.0..4.0)
      }

    @m_flareDefaults = {
      :lifetime_msec => 400,
      :flare_scale_range => (2.0..4.0)
      }
  
    @m_numEmbers = 10  
    @m_numFlares = 1  
    @m_numExplos = 1  
            
  end
  
  def mApplySpeedRange(ioParams, inSymbol)
    speedRange = ioParams[inSymbol]
    if speedRange
      unless speedRange.kind_of?(Range)
        speedRange = (0.0..speedRange)
      end

      ioParams[:post] = ioParams[:post].dup
      speed = speedRange.begin + rand * (speedRange.end - speedRange.begin)
      dispVec = MushTools.cRandomUnitVector * speed
      ioParams[:post].velocity = ioParams[:post].velocity + dispVec
    end
  end
  
  def mApplyScaleRange(ioParams, inSymbol)
    scaleRange = ioParams[inSymbol]
    if scaleRange
      unless scaleRange.kind_of?(Range)
        scaleRange = (0.0..scaleRange)
      end
      ioParams[:render_scale] = scaleRange.begin + rand * (scaleRange.end - scaleRange.begin)
    end
  end
  
  def mApplyLifetimeRange(ioParams, inSymbol)
    lifetimeRange = ioParams[inSymbol]
    if lifetimeRange
      unless lifetimeRange.kind_of?(Range)
        lifetimeRange = (0..lifetimeRange)
      end
      ioParams[:lifetime_msec] = lifetimeRange.begin + rand(lifetimeRange.end - lifetimeRange.begin)
    end
  end
  
  def mEmberCreate(inParams = {})
    mergedParams = @m_emberDefaults.merge(inParams)
  
    meshNum = mergedParams[:ember_number] || rand(@m_numEmberMeshes)
    mergedParams[:mesh_name] = "ember#{meshNum}"
    
    mApplySpeedRange(mergedParams, :ember_speed_range)
    mApplyScaleRange(mergedParams, :ember_scale_range)
    mApplyLifetimeRange(mergedParams, :ember_lifetime_range)
    
    AdanaxisPieceDeco.cCreate(mergedParams)
  end
  
  def mExploCreate(inParams = {})
    mergedParams = @m_exploDefaults.merge(inParams)
  
  
    meshNum = mergedParams[:explo_number]
    if meshNum.kind_of?(Range)
      meshNum = meshNum.begin + rand(meshNum.end - meshNum.begin)
    else
      meshNum ||= rand(@m_numExploMeshes)
    end

    mergedParams[:mesh_name] = "explo#{meshNum}"
    
    mApplySpeedRange(mergedParams, :explosion_speed_range)
    mApplyScaleRange(mergedParams, :explosion_scale_range)
    mApplyLifetimeRange(mergedParams, :explosion_lifetime_range)
    
    AdanaxisPieceDeco.cCreate(mergedParams)
  end
  
  def mFlareCreate(inParams = {})
    mergedParams = @m_flareDefaults.merge(inParams)

    meshNum = inParams[:flare_number] || rand(@m_numFlareMeshes)
        mergedParams[:mesh_name] = "flare#{meshNum}"

    mApplySpeedRange(mergedParams, :flare_speed_range)
    mApplyScaleRange(mergedParams, :flare_scale_range)
    mApplyLifetimeRange(mergedParams, :flare_lifetime_range)

    AdanaxisPieceDeco.cCreate(mergedParams)
  end

  def mExplode(inParams = {})
    objParams = inParams.dup
    objParams[:post] = objParams[:post].dup

    # Embers inherit a fraction of the object's velocity
    objParams[:post].velocity = objParams[:post].velocity * 0.5
  
    (objParams[:embers] || @m_numEmbers).times { mEmberCreate(objParams) }
    
    objParams[:post].velocity = MushVector.new(0,0,0,0)
    
    (objParams[:explosions] || @m_numExplos).times { mExploCreate(objParams) }
    (objParams[:flares] || @m_numFlares).times { mFlareCreate(objParams) }
  end
end

