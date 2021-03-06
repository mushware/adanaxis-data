#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisPieceKhazi.rb
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
#%Header } IJfBf/AMNEcB7c/jecIVzQ
# $Id: AdanaxisPieceKhazi.rb,v 1.47 2007/06/27 12:58:11 southa Exp $
# $Log: AdanaxisPieceKhazi.rb,v $
# Revision 1.47  2007/06/27 12:58:11  southa
# Debian packaging
#
# Revision 1.46  2007/06/08 16:23:03  southa
# Level 26
#
# Revision 1.45  2007/06/06 15:11:20  southa
# Level 23
#
# Revision 1.44  2007/06/06 12:24:13  southa
# Level 22
#
# Revision 1.43  2007/05/29 13:25:56  southa
# Level 20
#
# Revision 1.42  2007/05/10 11:44:11  southa
# Level15
#
# Revision 1.41  2007/05/09 19:24:43  southa
# Level 14
#
# Revision 1.40  2007/05/08 15:28:13  southa
# Level 12
#
# Revision 1.39  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.38  2007/03/28 14:45:46  southa
# Level and AI standoff
#
# Revision 1.37  2007/03/27 15:34:42  southa
# L4 and carrier ammo
#
# Revision 1.36  2007/03/26 16:31:35  southa
# L2 work
#
# Revision 1.35  2007/03/24 18:07:22  southa
# Level 3 work
#
# Revision 1.34  2007/03/23 18:39:08  southa
# Carriers and spawning
#
# Revision 1.33  2007/03/23 12:27:34  southa
# Added levels and Cistern mesh
#
# Revision 1.32  2007/03/21 11:56:05  southa
# Rail effects and damage icons
#
# Revision 1.31  2007/03/20 20:36:54  southa
# Solid renderer fixes
#
# Revision 1.30  2007/03/13 18:21:36  southa
# Scanner jamming
#
# Revision 1.29  2007/03/13 12:22:49  southa
# Scanner symbols
#
# Revision 1.28  2006/12/14 15:59:22  southa
# Fire and cutscene fixes
#
# Revision 1.27  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.26  2006/11/10 20:17:11  southa
# Audio work
#
# Revision 1.25  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.24  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.23  2006/11/01 13:04:21  southa
# Initial weapon handling
#
# Revision 1.22  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.21  2006/10/20 15:38:51  southa
# Item collection
#
# Revision 1.20  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.19  2006/10/16 22:00:20  southa
# Tweaks
#
# Revision 1.18  2006/10/16 15:25:57  southa
# Explosion lifetimes
#
# Revision 1.17  2006/10/16 14:36:50  southa
# Deco handling
#
# Revision 1.16  2006/10/14 16:59:43  southa
# Ruby Deco objects
#
# Revision 1.15  2006/10/13 14:21:25  southa
# Collision handling
#
# Revision 1.14  2006/10/08 11:31:31  southa
# Hit points
#
# Revision 1.13  2006/10/04 14:54:33  southa
# AI tweaks
#
# Revision 1.12  2006/10/04 13:35:21  southa
# Selective targetting
#
# Revision 1.11  2006/10/03 14:06:49  southa
# Khazi and projectile creation
#
# Revision 1.10  2006/09/30 13:46:32  southa
# Seek and patrol
#
# Revision 1.9  2006/09/29 10:47:56  southa
# Object AI
#
# Revision 1.8  2006/08/25 11:06:07  southa
# Snapshot
#
# Revision 1.7  2006/08/25 01:44:56  southa
# Khazi fire
#
# Revision 1.6  2006/08/24 16:30:55  southa
# Event handling
#
# Revision 1.5  2006/08/24 13:04:37  southa
# Event handling
#
# Revision 1.4  2006/08/20 14:19:20  southa
# Seek operation
#
# Revision 1.3  2006/08/19 09:12:09  southa
# Event handling
#
# Revision 1.2  2006/08/17 12:18:10  southa
# Event handling
#
# Revision 1.1  2006/08/17 08:57:10  southa
# Event handling
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'
require 'AdanaxisEvents.rb'
require 'AdanaxisPieceProjectile.rb'
require 'AdanaxisScanner.rb'
require 'AdanaxisUtil.rb'

class AdanaxisPieceKhazi < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)

    @m_defaultType = "k"
    super

    @m_callInterval = 100

    aiParams = {
      :seek_speed => 0.02,
      :seek_acceleration => 0.01,
      :patrol_speed => 0.1,
      :patrol_acceleration => 0.01
    }.merge(inParams)

    @m_ai = (inParams[:ai_object] || AdanaxisAIKhazi).new(aiParams)
    @m_remnant = inParams[:remnant]
    @m_weaponName = inParams[:weapon] || nil
    @m_weapon = $currentGame.mSpace.mWeaponLibrary.mWeapon(@m_weaponName)
    @m_weapon.mAmmoCountSet(inParams[:ammo_count]) if inParams[:ammo_count]
    @m_scannerSymbol = inParams[:scanner_symbol] || AdanaxisScanner::SYMBOL_KHAZI_PLAIN
    @m_isJammer = inParams[:is_jammer] || false
    @m_isStealth = inParams[:is_stealth] || false
    @m_effectScale = inParams[:effect_scale] || @m_hitPoints / 10.0
    @m_colour = inParams[:colour]
  end

  mush_reader :m_weapon, :m_weaponName, :m_colour

  def mDamageTake(inDamage, inPiece)
    # Hard targets only affected by high yield weapons, so
    unless mOriginalHitPoints >= 500.0 && inPiece.mHitPoints < 100.0
      super
    end
  end

  def mWeaponChange(inWeapon)
    if @m_weaponName != inWeapon
      @m_weaponName = inWeapon
      @m_weapon = $currentGame.mSpace.mWeaponLibrary.mWeapon(@m_weaponName)
    end
  end

  def mFireHandle(event)
    if @m_weapon
      @m_weapon.mFire(event, self)
    end
  end

  def mEventHandle(event)
    case event
      when AdanaxisEventFire then mFireHandle(event)
      else super
    end
    @m_callInterval
  end

  def mActionTimer
    mLoad

    @m_callInterval = @m_ai.mActByState(self)

    mSave

    @m_callInterval
  end

  def mFire
    if @m_weapon && @m_weapon.mFireOpportunityTake
      event = AdanaxisEventFire.new
      event.mPostSet(@m_post)
      if @m_ai && @m_ai.mTargetID
        event.mTargetIDSet(@m_ai.mTargetID)
      end
      $currentLogic.mEventConsume(event, @m_id, @m_id)
    end
  end

  def mCollectItem(inItem)
    if @m_weaponName == :khazi_rail && inItem.mItemType == :player_rail
      @m_weapon.mAmmoCountSet(@m_weapon.mAmmoCount + 6)
      MushGame.cSoundPlay("load4", mPost)
    end
  end

  def mFatalCollisionHandle(event)
    super
    # Choose numbers
    isNuclear = event.mPiece2.kind_of?(AdanaxisPieceEffector) && !event.mPiece2.mRail
    numEmbers = isNuclear ? 0 : 100
    numFlares = isNuclear ? 0 : 1
    exploNum = $currentLogic.mEffects.mExplode(
      :post => mPost,
      :embers => numEmbers,
      :explosions => 1,
      :flares => numFlares,
      :effect_scale => @m_effectScale
      )
    MushGame.cSoundPlay("explo#{exploNum}", mPost) if exploNum

    objPost = mPost.dup
    angVel = MushTools.cRotationInXYPlane(Math::PI / 200);
    MushTools.cRotationInZWPlane(Math::PI / 473).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 670).mRotate(angVel);

    objPost.velocity = MushVector.new(0,0,0,0)
    objPost.angular_velocity = angVel

    case event.mPiece2
      when AdanaxisPieceProjectile
        mRemnantCreate if event.mPiece2.mOwner =~ /^p/
      when AdanaxisPieceEffector
        if event.mPiece2.mOwner =~ /^p/ && !event.mPiece2.mRail
          mRemnantCreate
        end
    end

  end

  def mCollisionHandle(event)
    super
    case event.mPiece2
      when AdanaxisPieceProjectile
        @m_ai.mTargetOverride(event.mPiece2.mOwner)

      when AdanaxisPieceItem
        if @m_hitPoints > 0.0
          mCollectItem(event.mPiece2)
          event.mPiece2.mExpireFlagSet(true)
        end
    end
  end

  def mDamageFrameCreate(inHitPoints)
    AdanaxisPieceEffector.cCreate(
      :mesh_name => 'nuke_splash',
      :post => mPost,
      :owner => mId,
      :lifetime_msec => 0,
      :hit_points => inHitPoints,
      :vulnerability => 0.0
    )
  end

  def mDetonate
    # For mines
    mExpireFlagSet(true)
    mDamageFrameCreate(@m_originalHitPoints * 4)

    $currentLogic.mEffects.mExplode(
        :post => mPost,
        :embers => 0,
        :explosions => 0,
        :flares => 2,
        :flare_scale_range => @m_originalHitPoints * 4,
        :flare_lifetime_range => (3000..6000)
      )
    MushGame.cSoundPlay('explo7', mPost)
  end
end

# Class: AdanaxisPieceKhazi
#
# Description:
#
# This object is used to define or reference a new Khazi object.
#
# Method: cCreate
#
# Creates a new AdanaxisKhazi object.
#
# Parameters:
#
# post - Position/velocity <MushPost>
# mesh_name - Name of a previously created <MushMesh>.  A warning will be generated no mesh name is supplied
#
# Parameters must be supplied as a hash.
#
# Returns:
#
# New AdanaxisKhazi object
#
# Default:
#
# The default constructor creates an object with zero-values positions and velocities,
# and no mesh.
#
# Example:
#
# (example)
# post1 = AdanaxisPieceKhazi.cCreate
# post2 = AdanaxisPieceKhazi.cCreate(
#   post => MushPost.new(
#     :position => MushVector.new(1,2,3,4),
#     :angular_position => MushTools.cRotationInXYPlane(Math::PI/2),
#     :velocity => MushVector.new(0,0,0,-0.3),
#     :angular_velocity => MushTools.cRotationInZWPlane(Math::PI/20)
#   ),
#   :mesh_name => 'mymesh'
# )
#
# (end)
#
# Method: post
#
# Returns:
#
# Position/velocity <MushPost>
#
# Method: post=
#
# Sets the position and velocity.
#
# Parameter:
#
# Position/velocity <MushPost>
#
# Group: Links
#- Implemetation file:doxygen/class_adanaxis_piece_khazi.html
