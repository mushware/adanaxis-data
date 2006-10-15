#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisEffects.rb
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
#%Header } RVKExAJp3XSTK1irqyfmog
# $Id$
# $Log$

class AdanaxisEffects < MushObject
  def initialize
    @m_numEmberMeshes = 10
    @m_numExploMeshes = 10
    @m_numFlareMeshes = 10
    
    @m_emberDefaults = {
      :lifetime_msec => 1000,
      :random_speed => 1.0,
      :random_scale => (0.1..0.4)
      }

    @m_exploDefaults = {
      :lifetime_msec => 2000,
      :render_scale => 3.0
      }

    @m_flareDefaults = {
      :lifetime_msec => 400,
      :render_scale => 3.0
      }
  
    @m_numEmbers = 10  
            
  end
  
  def mEmberCreate(inParams = {})
    mergedParams = @m_emberDefaults.merge(inParams)
  
    meshNum = mergedParams[:ember_number] || rand(@m_numEmberMeshes)
    
    mergedParams[:mesh_name] = "ember#{meshNum}"
    
    speedRange = mergedParams[:random_speed]
    if speedRange
    
      unless speedRange.kind_of?(Range)
        speedRange = (0.0..speedRange)
      end

      speed = speedRange.begin + rand * (speedRange.end - speedRange.begin)
      
      newPost = mergedParams[:post].dup
      newPost.velocity = newPost.velocity + MushTools.cRandomUnitVector * speed
      
      mergedParams[:post] = newPost
    end
    
    scaleRange = mergedParams[:random_scale]
    if scaleRange
      unless scaleRange.kind_of?(Range)
        scaleRange = (0.0..scaleRange)
      end

      mergedParams[:render_scale] = scaleRange.begin + rand * (scaleRange.end - scaleRange.begin)
    end
    
    AdanaxisPieceDeco.cCreate(mergedParams)
  end
  
  def mExploCreate(inParams = {})
    meshNum = inParams[:explo_number] || rand(@m_numExploMeshes)
    
    AdanaxisPieceDeco.cCreate(
      @m_exploDefaults.merge(inParams).merge(
      :mesh_name => "explo#{meshNum}"
      )
    )
  end
  
  def mFlareCreate(inParams = {})
    meshNum = inParams[:flare_number] || rand(@m_numFlareMeshes)
    
    AdanaxisPieceDeco.cCreate(
      @m_flareDefaults.merge(inParams).merge(
      :mesh_name => "flare#{meshNum}"
      )
    )
  end
  
  def mExplode(inParams = {})
    objParams = inParams.dup
  
    # Embers inherit a fraction of the object's velocity
    objParams[:post].velocity = objParams[:post].velocity * 0.5
  
    numEmbers = objParams[:num_embers] || @m_numEmbers

    numEmbers.times do
      mEmberCreate(objParams)
    end
    
    objParams[:post].velocity = MushVector.new(0,0,0,0)
    
    mFlareCreate(objParams)
    #mExploCreate(objParams)
  end
end

