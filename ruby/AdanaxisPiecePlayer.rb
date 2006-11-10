#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPiecePlayer.rb
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
#%Header } 1H+rLloObKxiiVjoIDjJFw
# $Id: AdanaxisPiecePlayer.rb,v 1.8 2006/11/03 18:46:31 southa Exp $
# $Log: AdanaxisPiecePlayer.rb,v $
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
    :player_base0,
    :player_base1,
    :player_base2,
    :player_base3,
    :player_base4,
    :player_base5,
    :player_base6,
    :player_base7,
    :player_base8,
    :player_super_nuker
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
    @m_weapon = $currentGame.mSpace.mWeaponLibrary.mWeapon(@@c_weaponList[@m_weaponNum])
    @m_fireState = false
    @m_callInterval = 100
  end

  mush_accessor :m_shield, :m_originalShield
  
  def mShieldRatio
    @m_shield / @m_originalShield
  end
  
  def mVulnerability
    vuln = ((150.0 - @m_shield) / 150.0) - 0.2
    vuln = 0.0 if vuln < 0.0
    vuln = 1.0 if vuln > 1.0 || @m_shield == 0
    
    return vuln
  end
  
  def mDamageTake(inDamage)
    @m_shield -= inDamage
    @m_shield = 0.0 if @m_shield < 0.0
    super
  end
  
  def mNewWeapon(inNum)
    @m_weaponNum = inNum
    @m_weaponNum = 0 if @m_weaponNum >= @@c_weaponList.size
    @m_weaponNum = @@c_weaponList.size - 1 if @m_weaponNum < 0
    @m_weapon = $currentGame.mSpace.mWeaponLibrary.mWeapon(@@c_weaponList[@m_weaponNum])
    MushGame.cSoundPlay("load#{@m_weaponNum}", mPost)
  end
  
  def mFire
    if @m_weapon.mFireOpportunityTake
      event = AdanaxisEventFire.new
      event.mPostSet(@m_post)
      $currentLogic.mEventConsume(event, @m_id, @m_id)
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
    mLoad

    mFire if @m_fireState

    $currentGame.mView.mDashboard.mUpdate(
      :hit_point_ratio => mHitPointRatio,
      :shield_ratio => mShieldRatio
      )

    @m_callInterval
  end
  
  def mCollectItem(inItem)
    $currentLogic.mRemnant.mCollect(inItem, self)
  end
  
  def mCollisionHandle(event)
    super

    case event.mPiece2
      when AdanaxisPieceItem:
        mCollectItem(event.mPiece2)
        event.mPiece2.mExpireFlagSet(true)
    end
  end
  
  def mFireHandle(event)
    mLoad
    if @m_weapon
      @m_weapon.mFire(event, self)
    end
  end
  
  def mKeyStateHandle(event)
    event.mState.each_with_index do |state, i|
      keyNum = event.mKeyNum[i]

      if keyNum == AdanaxisControl::KEY_FIRE
        @m_fireState = state
      end
    
      if state
        case keyNum
          when AdanaxisControl::KEY_WEAPON_PREVIOUS
            mNewWeapon(@m_weaponNum - 1)
          when AdanaxisControl::KEY_WEAPON_NEXT
            mNewWeapon(@m_weaponNum + 1)
          when AdanaxisControl::KEY_WEAPON_0..AdanaxisControl::KEY_WEAPON_9
            mNewWeapon(keyNum - AdanaxisControl::KEY_WEAPON_0)
        end
      end
    end
  end
end
