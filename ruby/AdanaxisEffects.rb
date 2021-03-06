#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisEffects.rb
#
# Copyright: Andy Southgate 2002-2007, 2020
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##############################################################################
#%Header } 0h3QwvH8d1+Sa4do4NMbZA
# $Id: AdanaxisEffects.rb,v 1.11 2007/06/27 12:58:10 southa Exp $
# $Log: AdanaxisEffects.rb,v $
# Revision 1.11  2007/06/27 12:58:10  southa
# Debian packaging
#
# Revision 1.10  2007/06/14 22:24:26  southa
# Level and gameplay tweaks
#
# Revision 1.9  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.8  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.7  2007/03/21 11:56:05  southa
# Rail effects and damage icons
#
# Revision 1.6  2007/03/13 21:45:07  southa
# Release process
#
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
      speed = MushUtil.cRandomValInRange(speedRange)
      ioParams[:post] = ioParams[:post].dup
      dispVec = MushTools.cRandomUnitVector * speed
      ioParams[:post].velocity = ioParams[:post].velocity + dispVec
    end
  end

  def mApplyScaleRange(ioParams, inSymbol)
    scaleRange = ioParams[inSymbol]
    ioParams[:render_scale] = MushUtil.cRandomValInRange(scaleRange) if scaleRange
  end

  def mApplyLifetimeRange(ioParams, inSymbol)
    lifetimeRange = ioParams[inSymbol]
    if lifetimeRange
      ioParams[:lifetime_msec] = MushUtil.cRandomValInRange(lifetimeRange)
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


    exploNum = mergedParams[:explo_number]
    if exploNum.kind_of?(Range)
      exploNum = exploNum.begin + rand(exploNum.end - exploNum.begin)
    else
      exploNum ||= rand(@m_numExploMeshes)
    end

    mergedParams[:mesh_name] = "explo#{exploNum}"

    mApplySpeedRange(mergedParams, :explosion_speed_range)
    mApplyScaleRange(mergedParams, :explosion_scale_range)
    mApplyLifetimeRange(mergedParams, :explosion_lifetime_range)

    AdanaxisPieceDeco.cCreate(mergedParams)
    return exploNum
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

    effectScale = objParams[:effect_scale]
    if (effectScale)
      rootScale = Math.sqrt(effectScale)
      objParams[:ember_speed_range] ||= (rootScale * 0.3 .. rootScale * 1.0)
      objParams[:ember_lifetime_range] ||= (1000 * rootScale .. 2000 * rootScale)
      objParams[:explosion_scale_range] ||= (effectScale * 6.0 .. effectScale * 7.0)
      objParams[:explosion_lifetime_range] ||= (rootScale * 1000 .. rootScale * 1200)
      objParams[:flare_scale_range] ||= (effectScale * 12.0 .. effectScale * 15.0)
      objParams[:flare_lifetime_range] ||= (rootScale * 1000 .. rootScale * 1200)

      exploMin = MushUtil.cClamped(Integer(effectScale)-2, 0, 6)
      exploMax = MushUtil.cClamped(Integer(effectScale)+1, 2, 7)

      objParams[:explo_number] ||= (exploMin..exploMax)
    end

    # Embers inherit a fraction of the object's velocity
    objParams[:post].velocity = objParams[:post].velocity * 0.5

    (objParams[:embers] || @m_numEmbers).times { mEmberCreate(objParams) }

    objParams[:post].velocity = MushVector.new(0,0,0,0)

    exploNum = nil
    (objParams[:explosions] || @m_numExplos).times { exploNum = mExploCreate(objParams) }
    (objParams[:flares] || @m_numFlares).times { mFlareCreate(objParams) }

    return exploNum
  end
end

