#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisWeapon.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 2tVPM89yFBzn4dSGgYG41w
# $Id: AdanaxisWeapon.rb,v 1.24 2007/06/05 12:15:14 southa Exp $
# $Log: AdanaxisWeapon.rb,v $
# Revision 1.25  2007/06/27 12:58:13  southa
# Debian packaging
#
# Revision 1.24  2007/06/05 12:15:14  southa
# Level 21
#
# Revision 1.23  2007/05/29 13:25:56  southa
# Level 20
#
# Revision 1.22  2007/05/21 13:32:52  southa
# Flush weapon
#
# Revision 1.21  2007/05/09 19:24:43  southa
# Level 14
#
# Revision 1.20  2007/04/26 16:22:41  southa
# Level 9
#
# Revision 1.19  2007/04/26 13:12:39  southa
# Limescale and level 9
#
# Revision 1.18  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.17  2007/03/28 14:45:46  southa
# Level and AI standoff
#
# Revision 1.16  2007/03/27 15:34:42  southa
# L4 and carrier ammo
#
# Revision 1.15  2007/03/26 16:31:35  southa
# L2 work
#
# Revision 1.14  2007/03/24 18:07:23  southa
# Level 3 work
#
# Revision 1.13  2007/03/23 18:39:08  southa
# Carriers and spawning
#
# Revision 1.12  2007/03/21 18:05:53  southa
# Tied sound fixes
#
# Revision 1.11  2007/03/21 11:56:05  southa
# Rail effects and damage icons
#
# Revision 1.10  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.9  2006/12/11 18:54:18  southa
# Positional audio
#
# Revision 1.8  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.7  2006/11/14 14:02:16  southa
# Ball projectiles
#
# Revision 1.6  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.5  2006/11/12 14:39:50  southa
# Player weapons amd audio fix
#
# Revision 1.4  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.3  2006/11/02 12:23:21  southa
# Weapon selection
#
# Revision 1.2  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.1  2006/11/01 13:04:21  southa
# Initial weapon handling
#

class AdanaxisWeapon < MushObject
  @@c_defaultOffset = [MushVector.new(0,0,0,0)]
  @@c_defaultAngularVelocity = MushTools.cRotationInXYPlane(0.02)
  MushTools.cRotationInXZPlane(0.05).mRotate(@@c_defaultAngularVelocity)
  MushTools.cRotationInYZPlane(0.07).mRotate(@@c_defaultAngularVelocity)

  def initialize(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_projectileMesh = inParams[:projectile_mesh]
    @m_lifetimeMsec = inParams[:lifetime_msec] || 10000
    @m_speed = inParams[:speed] || 1.0
    @m_acceleration = inParams[:acceleration] || 0.0
    @m_speedLimit = inParams[:speed_limit] || 0.0
    @m_fireRateMsec = inParams[:fire_rate_msec] || 1000
    @m_offsetSequence = inParams[:offset_sequence] || @@c_defaultOffset
    @m_offsetNumber = 0
    @m_fireSound = inParams[:fire_sound]
    @m_reloadSound = inParams[:reload_sound]
    @m_angularVelocity = inParams[:angular_velocity] || @@c_defaultAngularVelocity
    @m_hitPoints = inParams[:hit_points] || 1.0
    @m_aiParams = inParams[:ai_params]
    @m_numProjectiles = inParams[:num_projectiles] || 1
    @m_deviation = inParams[:deviation]
    @m_type = inParams[:type] || nil
    @m_itemType = inParams[:item_type] || nil
    @m_ammoCount = inParams[:ammo_count] || nil
    @m_spawnLimit = inParams[:spawn_inhibit_limit] || 20 * (1+AdanaxisRuby.cGameDifficulty)
    @m_alphaStutter = inParams[:alpha_stutter] || 0.0
    @m_isFlush = inParams[:is_flush]
    @m_jammable = inParams[:jammable]
    @m_lastFireMsec = 0
  end

  mush_accessor :m_ammoCount

  def mFireOpportunityTake
    retVal = false
    if @m_lastFireMsec + @m_fireRateMsec < MushGame.cGameMsec && @m_ammoCount != 0
      @m_lastFireMsec = MushGame.cGameMsec
      unless @m_type == :spawner && $currentGame.mSpace.mKhaziRedCount > @m_spawnLimit
        retVal = true
      end
    end
    retVal
  end

  def mCommonFire(inEvent, inPiece, inProjPost)
    @m_lastFireMsec = MushGame.cGameMsec
    @m_offsetNumber += 1
    @m_offsetNumber = 0 if @m_offsetNumber >= @m_offsetSequence.size

    MushGame.cTiedSoundPlay(@m_fireSound, inProjPost) if @m_fireSound
    MushGame.cTiedSoundPlay(@m_reloadSound, inProjPost) if @m_reloadSound

    @m_ammoCount -= 1 if @m_ammoCount

  end

  def mProjectileFire(inEvent, inPiece)
    projPost = inEvent.mPost.dup

    # Get player forward velocity but not transverse
    vel = projPost.velocity
    projPost.angular_position.mInverse.mRotate(vel)
    vel.x = 0
    vel.y = 0
    vel.z = 0
    vel.w = vel.w - @m_speed

    offset = @m_offsetSequence[@m_offsetNumber].dup

    projPost.angular_position.mRotate(offset)
    projPost.angular_position.mRotate(vel)

    projPost.position = projPost.position + offset
    projPost.velocity = vel

    # Apply the angular velocity in the object frame
    if @m_type == :rocket
      projPost.angular_velocity = MushRotation.new
    else
      angVel = projPost.angular_position.mInverse
      @m_angularVelocity.mRotate(angVel)
      projPost.angular_position.mRotate(angVel)
      projPost.angular_velocity = angVel
    end

    if @m_aiParams
      aiParams = @m_aiParams.merge(
        :target_id => inEvent.mTargetID
      )
      if @m_jammable && $currentGame.mSpace.mJamming
        aiParams[:seek_acceleration] *= -1.0
      end
    end

    baseVelocity = projPost.velocity
    lifetime = @m_lifetimeMsec
    @m_numProjectiles.times do
      projPost.velocity = baseVelocity + MushTools.cRandomUnitVector * @m_deviation if @m_deviation
      lifetime = @m_lifetimeMsec.begin + rand(@m_lifetimeMsec.end - @m_lifetimeMsec.begin) if @m_lifetimeMsec.kind_of?(Range)
      AdanaxisPieceProjectile.cCreate(
        :mesh_name => @m_projectileMesh,
        :post => projPost,
        :owner => inPiece.mId,
        :lifetime_msec => lifetime,
        :hit_points => @m_hitPoints,
        :acceleration => @m_acceleration,
        :speed_limit => @m_speedLimit,
        :ai_params => aiParams,
        :is_rocket => (@m_type == :rocket),
        :is_flush => @m_isFlush,
        :alpha_stutter => @m_alphaStutter
      )
    end

    mCommonFire(inEvent, inPiece, projPost)

    nil
  end

  def mItemFire(inEvent, inPiece)
    projPost = inEvent.mPost.dup

    vel = projPost.velocity
    projPost.angular_position.mInverse.mRotate(vel)
    vel.x = 0
    vel.y = 0
    vel.z = 0
    vel.w = vel.w - @m_speed

    offset = @m_offsetSequence[@m_offsetNumber].dup

    projPost.angular_position.mRotate(offset)
    projPost.angular_position.mRotate(vel)

    projPost.position = projPost.position + offset
    projPost.velocity = vel

    # Apply the angular velocity in the object frame

    angVel = projPost.angular_position.mInverse
    @m_angularVelocity.mRotate(angVel)
    projPost.angular_position.mRotate(angVel)
    projPost.angular_velocity = angVel

    if @m_aiParams
      aiParams = @m_aiParams.merge(
        :target_id => inEvent.mTargetID
      )
    end

    baseVelocity = projPost.velocity
    lifetime = @m_lifetimeMsec
    @m_numProjectiles.times do
      projPost.velocity = baseVelocity + MushTools.cRandomUnitVector * @m_deviation if @m_deviation
      lifetime = @m_lifetimeMsec.begin + rand(@m_lifetimeMsec.end - @m_lifetimeMsec.begin) if @m_lifetimeMsec.kind_of?(Range)
      AdanaxisPieceItem.cCreate(
        :item_type => @m_itemType,
        :mesh_name => @m_projectileMesh,
        :post => projPost,
        :owner => inPiece.mId,
        :lifetime_msec => lifetime,
        :hit_points => @m_hitPoints,
        :acceleration => @m_acceleration,
        :speed_limit => @m_speedLimit,
        :ai_params => aiParams,
        :is_rocket => (@m_type == :rocket),
        :is_flush => @m_isFlush,
        :alpha_stutter => @m_alphaStutter
      )
    end

    mCommonFire(inEvent, inPiece, projPost)

    nil
  end

  def mRailFire(inEvent, inPiece)
    projPost = inEvent.mPost.dup
    offset = @m_offsetSequence[@m_offsetNumber].dup

    # Apply the angular velocity in the object frame
    angVel = projPost.angular_position.mInverse
    @m_angularVelocity.mRotate(angVel)
    projPost.angular_position.mRotate(angVel)
    projPost.angular_velocity = angVel

    baseVelocity = projPost.velocity
    lifetime = @m_lifetimeMsec

    # Create the effector before applying the offset, so the gunsight works as expected
    AdanaxisPieceEffector.cCreate(
      :rail => true,
      :mesh_name => @m_projectileMesh,
      :post => projPost,
      :owner => inPiece.mId,
      :lifetime_msec => 0,
      :hit_points => @m_hitPoints,
      :vulnerability => 0.0
    )

    projPost.angular_position.mRotate(offset)
    projPost.position = projPost.position + offset

    AdanaxisPieceDeco.cCreate(
      :mesh_name => @m_projectileMesh,
      :post => projPost,
      :lifetime_msec => lifetime
    )

    $currentLogic.mEffects.mFlareCreate(
      :post => projPost,
      :flare_lifetime_range => 400..500,
      :flare_scale_range => 4.0..4.4
    )

    mCommonFire(inEvent, inPiece, projPost)

    nil
  end

  def mSpawnerFire(inEvent, inPiece)
    projPost = inEvent.mPost.dup

    # Get firer forward velocity but not transverse
    vel = projPost.velocity
    projPost.angular_position.mInverse.mRotate(vel)
    vel.x = 0
    vel.y = 0
    vel.z = 0
    vel.w = vel.w - @m_speed

    offset = @m_offsetSequence[@m_offsetNumber].dup

    projPost.angular_position.mRotate(offset)
    projPost.angular_position.mRotate(vel)

    projPost.position = projPost.position + offset
    projPost.velocity = vel

    # Rotate spawned object so it faces the opposite way to the spawner
    angPos = projPost.angular_position
    # This combo send (x,y,z,w) to (-x,-y,-z,-w)
    MushTools.cRotationInXYPlane(Math::PI).mRotate(angPos)
    MushTools.cRotationInZWPlane(Math::PI).mRotate(angPos)
    projPost.angular_position = angPos

    # Apply the angular velocity in the object frame
    angVel = projPost.angular_position.mInverse
    @m_angularVelocity.mRotate(angVel)
    projPost.angular_position.mRotate(angVel)
    projPost.angular_velocity = angVel

    baseVelocity = projPost.velocity
    lifetime = @m_lifetimeMsec

    case @m_projectileMesh
      when :limescale
        $currentGame.mSpace.mPieceLibrary.mLimescaleCreate(
          :colour => inPiece.mColour,
          :post => projPost,
          :spawned => true
        )
      when :harpik
        $currentGame.mSpace.mPieceLibrary.mHarpikCreate(
          :colour => inPiece.mColour,
          :post => projPost,
          :spawned => true
        )
      when :vendor
        $currentGame.mSpace.mPieceLibrary.mVendorCreate(
          :colour => inPiece.mColour,
          :post => projPost,
          :spawned => true
        )
      else
        $currentGame.mSpace.mPieceLibrary.mAttendantCreate(
          :colour => inPiece.mColour,
          :post => projPost,
          :spawned => true
        )
    end

    mCommonFire(inEvent, inPiece, projPost)

    nil
  end

  def mFire(inEvent, inPiece)
    case @m_type
      when :item : mItemFire(inEvent, inPiece)
      when :spawner : mSpawnerFire(inEvent, inPiece)
      when :rail : mRailFire(inEvent, inPiece)
      else mProjectileFire(inEvent, inPiece)
    end
  end
end
