#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisPieceProjectile.rb
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
#%Header } DVEvJOGS+FtHVonAzFhHbA
# $Id: AdanaxisPieceProjectile.rb,v 1.22 2007/06/27 13:18:54 southa Exp $
# $Log: AdanaxisPieceProjectile.rb,v $
# Revision 1.22  2007/06/27 13:18:54  southa
# Debian packaging
#
# Revision 1.21  2007/06/27 12:58:12  southa
# Debian packaging
#
# Revision 1.20  2007/05/21 13:32:52  southa
# Flush weapon
#
# Revision 1.19  2007/04/26 13:12:39  southa
# Limescale and level 9
#
# Revision 1.18  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.17  2007/03/26 16:31:35  southa
# L2 work
#
# Revision 1.16  2007/03/13 21:45:08  southa
# Release process
#
# Revision 1.15  2006/11/14 14:02:15  southa
# Ball projectiles
#
# Revision 1.14  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.13  2006/11/12 14:39:50  southa
# Player weapons amd audio fix
#
# Revision 1.12  2006/11/03 18:46:31  southa
# Damage effectors
#
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
    @m_acceleration = inParams[:acceleration] || 0.0
    @m_speedLimit = inParams[:speed_limit] || 0.0

    aiParams = inParams[:ai_params]
    if aiParams
      @m_ai = AdanaxisAIProjectile.new(aiParams)
      @m_callInterval = 100
    else
      @m_callInterval = nil
    end
    @m_isRocket = inParams[:is_rocket]
    @m_isFlush = inParams[:is_flush]

    return @m_callInterval
  end

  mush_reader :m_owner

  def mActionTimer
    mLoad

    if @m_ai
      @m_callInterval = @m_ai.mActByState(self)
      @m_callInterval = 100 if @m_isRocket
    end

    mRocketEffect if @m_isRocket

    mSave

    @m_callInterval
  end

  def mRocketEffect
    flarePost = mPost.dup

    flareVel = MushVector.new(0,0,0,0.5)
    mPost.angular_position.mRotate(flareVel)
    flarePost.velocity = flarePost.velocity + flareVel

    flareScale = (mAgeMsec / 2000.0).mClamp(0.1, 5.0)
    $currentLogic.mEffects.mFlareCreate(
      :post => flarePost,
      :flare_lifetime_range => 500..600,
      :flare_scale_range => flareScale..flareScale * 1.2,
      :alpha_stutter => 0
    )
  end

  def mExplosionEffect
    if @m_originalHitPoints >= 50.0
      $currentLogic.mEffects.mExplode(
        :post => mPost,
        :embers => 0,
        :explosions => 0,
        :flares => 2,
        :flare_scale_range => @m_originalHitPoints,
        :flare_lifetime_range => (3000..6000)
      )
      MushGame.cSoundPlay("explo5", mPost)
    elsif @m_isRocket || @m_originalHitPoints >= 20.0
      $currentLogic.mEffects.mExplode(
        :post => mPost,
        :explosions => 1,
        :flares => 1,
        :effect_scale => 0.6
      )
      MushGame.cSoundPlay("explo0", mPost)
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

  def mExpiryEffect
    if @m_originalHitPoints > 50.0 || @m_isRocket
      mExplosionEffect
    else
      $currentLogic.mEffects.mExplode(
        :post => mPost,
        :embers => 3,
        :explosions => 0,
        :flares => 0
      )
    end
  end

  def mExplosionSound
    case @m_originalHitPoints
      when 0...100.0
      else
        MushGame.cSoundPlay('explo7', mPost)
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

  def mFlushFrameCreate
    framePost = mPost.dup
    framePost.velocity = MushVector.new
    AdanaxisPieceEffector.cCreate(
      :mesh_name => 'flush_splash',
      :post => framePost,
      :owner => mOwner,
      :lifetime_msec => 15000,
      :hit_points => 1.0,
      :vulnerability => 0.0,
      :is_flush => true
    )
    $currentLogic.mEffects.mFlareCreate(
      :post => framePost,
      :flare_lifetime_range => 18000..18000,
      :flare_scale_range => 4.0..4.0,
      :alpha_stutter => 0.2
    )
    $currentLogic.mEffects.mFlareCreate(
      :post => framePost,
      :flare_lifetime_range => 3000..3000,
      :flare_scale_range => 20.0..20.0,
      :alpha_stutter => 1.0
    )
    MushGame.cSoundPlay('explo6', framePost)
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
    if @m_isFlush
      mFlushFrameCreate
    end

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
      mExpiryEffect
      if @m_isFlush
        mFlushFrameCreate
      elsif @m_originalHitPoints > 10.0
        mDamageFrameCreate
      end
    end
  end
end
