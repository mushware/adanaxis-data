#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisPieceItem.rb
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
#%Header } W00FUF6tEtSgtXkfE5r64A
# $Id: AdanaxisPieceItem.rb,v 1.8 2007/05/29 13:25:56 southa Exp $
# $Log: AdanaxisPieceItem.rb,v $
# Revision 1.9  2007/06/27 12:58:11  southa
# Debian packaging
#
# Revision 1.8  2007/05/29 13:25:56  southa
# Level 20
#
# Revision 1.7  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.6  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.5  2007/03/13 21:45:08  southa
# Release process
#
# Revision 1.4  2006/11/01 10:07:13  southa
# Shield handling
#
# Revision 1.3  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.2  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.1  2006/10/19 15:41:35  southa
# Item handling
#

class AdanaxisPieceItem < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "i"
    super
    @m_owner = inParams[:owner] || ""
    @m_lifeMsec = inParams[:lifetime_msec] || 0
    mDamageFactorSet(inParams[:damage_factor] || 0.0)
    @m_itemType = inParams[:item_type] || raise(RuntimeError, "No item_type supplied")
    @m_callInterval = 1000
  end

  mush_accessor :m_itemType

  def mVulnerability
    # Items are invulnerable for a period after creation
    return (mAgeMsec < 2000) ? 0.0 : 1.0
  end

  def mActionTimer
    mLoad
    mDecoEffect

    @m_callInterval
  end

  def mDecoEffect
    $currentLogic.mEffects.mExplode(
      :post => mPost,
      :embers => 3,
      :explosions => 0,
      :flares => 0,
      :lifetime_msec => 3000,
      :ember_speed_range => (0.02..0.04),
      :ember_scale_range => (0.1..0.3)
    )
  end

  def mExplosionEffect
    $currentLogic.mEffects.mExplode(
      :post => mPost,
      :embers => 20,
      :explosions => 0,
      :flares => 1,
      :flare_scale_range => (1.7..2.0)
    )
  end

  def mExplosionSound
  end

  def mFatalCollisionHandle(event)
    super
    mExplosionEffect
    mExplosionSound
  end

  def mExpiryHandle(event)
    mLoad
    mExplosionEffect
    mExplosionSound
  end
end
