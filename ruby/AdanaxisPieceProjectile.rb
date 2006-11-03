#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceProjectile.rb
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
#%Header } JPjWkwGvzd5d5LJLXnphkQ
# $Id: AdanaxisPieceProjectile.rb,v 1.11 2006/10/30 19:36:38 southa Exp $
# $Log: AdanaxisPieceProjectile.rb,v $
# Revision 1.11  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.10  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.9  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.8  2006/10/17 11:05:54  southa
# Expiry events
#
# Revision 1.7  2006/10/16 14:36:50  southa
# Deco handling
#
# Revision 1.6  2006/10/15 17:12:53  southa
# Scripted explosions
#
# Revision 1.5  2006/10/14 16:59:43  southa
# Ruby Deco objects
#
# Revision 1.4  2006/10/13 14:21:26  southa
# Collision handling
#
# Revision 1.3  2006/10/04 13:35:21  southa
# Selective targetting
#
# Revision 1.2  2006/10/03 14:06:49  southa
# Khazi and projectile creation
#
# Revision 1.1  2006/08/25 01:44:56  southa
# Khazi fire
#

class AdanaxisPieceProjectile < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "f"
    super
    @m_owner = inParams[:owner] || ""
    @m_lifeMsec = inParams[:lifetime_msec] || 0
    @m_damageFrame = inParams[:damage_frame]
  end
  
  mush_reader :m_owner
  
  def mExplosionEffect
    if @m_originalHitPoints > 5.0
      $currentLogic.mEffects.mExplode(
        :post => mPost,
        :embers => 0,
        :explosions => 0,
        :flares => 2,
        :flare_scale_range => @m_originalHitPoints,
        :flare_lifetime_range => (3000..6000)
      )
    else
      $currentLogic.mEffects.mExplode(
        :post => mPost,
        :embers => 3,
        :explosions => 0,
        :flares => 1,
        :flare_scale_range => (1.7..2.0)
      )
    end
  end
  
  def mExplosionSound
    case @m_originalHitPoints
      when 0...100.0
      else
        MushGame.cSoundPlay('nuke_explo1', mPost)
    end
  end
  
  def mDamageFrameCreate
    AdanaxisPieceEffector.cCreate(
      :mesh_name => 'nuke_splash',
      :post => mPost,
      :owner => mOwner,
      :lifetime_msec => 0,
      :hit_points => @m_originalHitPoints,
      :vulnerability => 0.0
    )
  end

  def mFatalCollisionHandle(event)
    super
    mExplosionEffect
    mExplosionSound
    if @m_originalHitPoints > 10.0
      unless @m_damageFrame
        mDamageFrameCreate
      end
    end
  end
  
  def mCollisionHandle(event)
    if @m_damageFrame
      # Collisions don't affect damage frames - they just expire
    else
      mHitPointsSet(0.0) # Projectiles always get destroyed
      super
    end
  end
  
  def mExpiryHandle(event)
    unless @m_damageFrame
      mLoad
      mExplosionEffect
      mExplosionSound
      if @m_originalHitPoints > 10.0
        unless @m_damageFrame
          mDamageFrameCreate
        end
      end
    end
  end
end
