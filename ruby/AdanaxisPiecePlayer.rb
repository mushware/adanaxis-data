#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPiecePlayer.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.3, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } XoqG0JV9lVapjqhhSCgfAQ
# $Id: AdanaxisPiecePlayer.rb,v 1.28 2007/05/21 13:32:52 southa Exp $
# $Log: AdanaxisPiecePlayer.rb,v $
# Revision 1.28  2007/05/21 13:32:52  southa
# Flush weapon
#
# Revision 1.27  2007/05/10 14:06:25  southa
# Level 16 and retina spin
#
# Revision 1.26  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.25  2007/03/27 14:01:02  southa
# Attendant AI
#
# Revision 1.24  2007/03/26 16:31:35  southa
# L2 work
#
# Revision 1.23  2007/03/24 18:07:22  southa
# Level 3 work
#
# Revision 1.22  2007/03/23 18:39:08  southa
# Carriers and spawning
#
# Revision 1.21  2007/03/21 11:56:05  southa
# Rail effects and damage icons
#
# Revision 1.20  2007/03/19 16:01:34  southa
# Damage indicators
#
# Revision 1.19  2007/03/13 21:45:08  southa
# Release process
#
# Revision 1.18  2007/03/07 16:59:43  southa
# Khazi spawning and level ends
#
# Revision 1.17  2006/12/14 15:59:22  southa
# Fire and cutscene fixes
#
# Revision 1.16  2006/12/11 18:54:13  southa
# Positional audio
#
# Revision 1.15  2006/11/21 16:13:54  southa
# Cutscene handling
#
# Revision 1.14  2006/11/17 20:08:34  southa
# Weapon change and ammo handling
#
# Revision 1.13  2006/11/17 15:47:42  southa
# Ammo remnants
#
# Revision 1.12  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.11  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.10  2006/11/12 14:39:49  southa
# Player weapons amd audio fix
#
# Revision 1.9  2006/11/10 20:17:11  southa
# Audio work
#
# Revision 1.8  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.7  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.6  2006/11/01 10:07:13  southa
# Shield handling
#
# Revision 1.5  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.4  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.3  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.2  2006/10/04 13:35:21  southa
# Selective targetting
#
# Revision 1.1  2006/10/02 17:25:03  southa
# Object lookup and target selection
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'
require 'AdanaxisEvents.rb'

class AdanaxisPiecePlayer < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install
  
  @@c_weaponList = [
    :player_base,
    :player_light_cannon,
    :player_flak,
    :player_quad_cannon,
    :player_rail,
    :player_heavy_cannon,
    :player_light_missile,
    :player_heavy_missile,
    :player_flush,
    :player_nuclear
  ]
  
  def initialize(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "p"
    super
    @m_hitPoints = inParams[:hit_points] || 100.0
    @m_originalHitPoints = @m_hitPoints
    @m_shield = inParams[:shield] || 0.0
    @m_originalShield = 100.0
    @m_weaponNum = 0
    @m_weaponName = @@c_weaponList[@m_weaponNum]
    @m_weapon = $currentGame.mSpace.mWeaponLibrary.mWeapon(@m_weaponName)
    @m_magazine = AdanaxisMagazine.new
    @m_magazine.mPlayerLoadAll if $MUSHCONFIG['DEBUG']
    @m_fireState = false
    @m_numActions = 0
    @m_lastAmmoAddMsec = 0
    @m_controlReleased = false
    
    $currentGame.mView.mDashboard.mUpdate(
      :weapon_name => @m_weaponName,
      :ammo_count => @m_magazine.mAmmoCount(@m_weaponName)
    )

    @m_callInterval = 100
  end

  mush_accessor :m_shield, :m_originalShield, :m_magazine, :m_controlReleased
  
  def mShieldRatio
    @m_shield / @m_originalShield
  end
  
  def mVulnerability
    vuln = ((150.0 - @m_shield) / 150.0) - 0.2
    vuln = 0.0 if vuln < 0.0
    vuln = 1.0 if vuln > 1.0 || @m_shield == 0
    
    return vuln
  end
  
  def mDamageTake(inDamage, inPiece)
    @m_shield -= inDamage
    @m_shield = 0.0 if @m_shield < 0.0
    amount = super
    if amount > 0.0
      amount = MushUtil.cClamped(amount / 20.0, 0.5, 2.0)

      if inPiece.kind_of?(AdanaxisPieceEffector)
        incomingVel = mPost.position - inPiece.mPost.position
      else
        incomingVel = inPiece.mPost.velocity - mPost.velocity
      end
      mPost.angular_position.mInverse.mRotate(incomingVel)
      $currentGame.mView.mDashboard.mDamageUpdate(amount, incomingVel)
    end
  end
  
  def mNewWeapon(inWeapon)
    if inWeapon.kind_of?(Symbol)
      @m_weaponNum = @@c_weaponList.index(inWeapon)
      @m_weaponNum ||= 0
    else
      @m_weaponNum = inWeapon
    end
    @m_weaponNum = 0 if @m_weaponNum >= @@c_weaponList.size
    @m_weaponNum = @@c_weaponList.size - 1 if @m_weaponNum < 0
    @m_weaponName = @@c_weaponList[@m_weaponNum]
    @m_weapon = $currentGame.mSpace.mWeaponLibrary.mWeapon(@m_weaponName)
    @m_weapon.mFireOpportunityTake # Weapon inactive for its reload time
    MushGame.cTiedSoundPlay("load#{@m_weaponNum}", mPost)
    $currentGame.mView.mDashboard.mUpdate(
      :weapon_name => @m_weaponName,
      :ammo_count => @m_magazine.mAmmoCount(@m_weaponName)
    )
  end
  
  def mAmmoCollect(inType, inCount)
    mMagazine.mLimitedAmmoAdd(inType, inCount)
    
    weaponNum = @@c_weaponList.index(inType)
    if weaponNum && weaponNum > @m_weaponNum
      mNewWeapon(weaponNum)
    end
  end
  
  def mFire
    if @m_hitPoints > 0.0 && @m_weapon.mFireOpportunityTake
      if @m_magazine.mAmmoCount(@m_weaponName) <= 0
        @@c_weaponList.reverse_each do |name|
          if @m_magazine.mAmmoCount(name) > 0
            mNewWeapon(name)
            break
          end
        end
      else
        event = AdanaxisEventFire.new
        event.mPostSet(@m_post)
        event.mTargetIDSet(AdanaxisRuby.cPlayerTargetID)
        $currentLogic.mEventConsume(event, @m_id, @m_id)
        @m_magazine.mAmmoDecrement(@m_weaponName)
        $currentGame.mView.mDashboard.mUpdate(:ammo_count => @m_magazine.mAmmoCount(@m_weaponName))
      end
    end
  end
  
  def mEventHandle(event)
    case event
      when AdanaxisEventFire: mFireHandle(event)
      when AdanaxisEventKeyState: mKeyStateHandle(event)
      else super
    end
    @m_callInterval
  end
  
  def mActionTimer
    callInterval = @m_callInterval
    
    if @m_fireState || (@m_numActions % 8) == 0
      mLoad

      if @m_fireState
        mFire
        # Short call interval for smooth rapid fire
        callInterval = 0
      end
      
      if @m_lastAmmoAddMsec + 1000 < MushGame.cGameMsec
        if @m_magazine.mAmmoCount(:player_base) < 100
          @m_magazine.mLimitedAmmoAdd(:player_base, 1)
          if @m_weaponName == :player_base
            $currentGame.mView.mDashboard.mUpdate(:ammo_count => @m_magazine.mAmmoCount(@m_weaponName))
          end
        end
        @m_lastAmmoAddMsec = MushGame.cGameMsec
      end
    end
    
    $currentGame.mView.mDashboard.mUpdate(
      :hit_point_ratio => mHitPointRatio,
      :shield_ratio => mShieldRatio
    )
    
    @m_numActions += 1
    callInterval
  end
  
  def mCollectItem(inItem)
    $currentLogic.mRemnant.mCollect(inItem, self)
    $currentGame.mView.mDashboard.mUpdate(:ammo_count => @m_magazine.mAmmoCount(@m_weaponName))
  end
  
  def mFatalCollisionHandle(event)
    super

    3.times do |i|
      post = event.mPiece1.post.dup
      disp = MushVector.new(0,0,0,-10 * (i+1))
      post.angular_position.mRotate(disp)
      post.position = post.position + disp
        
      $currentLogic.mEffects.mExplode(
        :post => post,
        :embers => 0,
        :explosions => 1,
        :explo_number => 5+i,
        :flares => 1,
        :explosion_lifetime_range => (3000..4000),
        :explosion_scale_range => (14.0..15.0),
        :flare_scale_range => (50.0..60.0),
        :flare_lifetime_range => (1000..2000)
        )
    end
    
    post = event.mPiece1.post.dup
    post.velocity = MushVector.new(0,0,0,0)
    disp = MushVector.new(0,0,0,-1)
    post.angular_position.mRotate(disp)
    post.position = post.position + disp

    $currentLogic.mEffects.mExplode(
        :post => post,
        :embers => 100,
        :explosions => 0,
        :flares => 0,
        :ember_speed_range => (0.05..0.1),
        :ember_lifetime_range => (40000..60000)
    )
    
    post = event.mPiece1.post.dup
    disp = MushVector.new(-10,0,0,0)
    post.angular_position.mRotate(disp)
    post.position = post.position + disp
    MushGame.cSoundPlay("explo5", post)
    post = event.mPiece1.post.dup
    disp = MushVector.new(10,0,0,0)
    post.angular_position.mRotate(disp)
    post.position = post.position + disp
    MushGame.cSoundPlay("explo6", post)
    MushGame.cSoundPlay("explo7", mPost)
        
    # Remove other object
    event.mPiece2.mExpireFlagSet(true)
  end
  
  def mCollisionHandle(event)
    super

    case event.mPiece2
      when AdanaxisPieceItem:
        if @m_hitPoints > 0.0
          mCollectItem(event.mPiece2)
          event.mPiece2.mExpireFlagSet(true)
        end
    end
  end
  
  def mFireHandle(event)
    mLoad
    if @m_weapon
      @m_weapon.mFire(event, self)
    end
  end
  
  def mKeyStateHandle(event)
    mLoad
    event.mState.each_with_index do |state, i|
      keyNum = event.mKeyNum[i]

      if keyNum == AdanaxisControl::KEY_FIRE
        @m_fireState = state
      end
    
      if state
        numWeapons = @@c_weaponList.size
        case keyNum
          when AdanaxisControl::KEY_WEAPON_PREVIOUS
            (numWeapons-1).times do |i|
              newNum = (@m_weaponNum+numWeapons-i-1) % numWeapons
              if @m_magazine.mAmmoCount(@@c_weaponList[newNum]) > 0
                mNewWeapon(newNum)
                break
              end
            end
          when AdanaxisControl::KEY_WEAPON_NEXT
            (numWeapons-1).times do |i|
              newNum = (@m_weaponNum+i+1) % numWeapons
              if @m_magazine.mAmmoCount(@@c_weaponList[newNum]) > 0
                mNewWeapon(newNum)
                break
              end
            end
          when AdanaxisControl::KEY_WEAPON_0..AdanaxisControl::KEY_WEAPON_9
            mNewWeapon(keyNum - AdanaxisControl::KEY_WEAPON_0)
        end
      end
    end
  end
end
