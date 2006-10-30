#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceItem.rb
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
#%Header } Wc8DiQMb3X3SK/ndcDlP7Q
# $Id: AdanaxisPieceItem.rb,v 1.2 2006/10/30 17:03:50 southa Exp $
# $Log: AdanaxisPieceItem.rb,v $
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
    @m_lifeMsec = inParams[:lifetime_msec] || 0
    mDoesDamageSet(inParams[:does_damage] || false)
    @m_itemType = inParams[:item_type] || raise(RuntimeError, "No item_type supplied")
    @m_callInterval = 1000
  end
  
  mush_accessor :m_itemType
  
  def mVulnerable
    # Items are invulnerable for a period after creation
    return mAgeMsec > 3000
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
