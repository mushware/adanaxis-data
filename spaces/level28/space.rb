#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level28/space.rb
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
#%Header } PyjZgKO+Zh1BoaVMqvODDA
# $Id: space.rb,v 1.1 2007/06/12 11:09:37 southa Exp $
# $Log: space.rb,v $
# Revision 1.1  2007/06/12 11:09:37  southa
# Level 28
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level28 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mTimeoutSpawnAdd(:mSpawn0, 30000)
    mTimeoutSpawnAdd(:mSpawn1, 60000)

    mTimeOnlySpawnAdd(:mSpawn2, 90000)
    
    mIsBattleSet(true)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L28.ogg")
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mVortexTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(28)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);
  
    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)
  
    1.times do |param|
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(20, 20, -100, -500),
          :angular_velocity => angVel
        )
      )
    end
    
    (3+diff).times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(500, 0, 0, -600) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 12000+1000*param
        )
    end
    
    2.times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'blue',
          :post => MushPost.new(
            :position => MushVector.new(-500, 0, 0, -600) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 9500+1000*param
        )
    end
    
    15.times do |param|
      ['blue', 'red'].each do |colour|
        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(((colour == 'red')?100:-100), 0, 0, -500) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
    end

    4.times do |param|
      ['blue', 'red'].each do |colour|
        mPieceLibrary.mHarpikCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(((colour == 'red')?300:-300), 200, 0, -500) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(400+100*param, -20, 0, -400),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-400, 50*param, 0, -450),
          MushVector.new(400, 50*param, 0, -450)
          ],
        :ammo_count => 1 + diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param,
        :weapon => :limescale_spawner
      )
    end
   
    [-1,1].each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200, 40*param, -50, -450+50*param),
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-500, 40*param, -50, -450+50*param),
          MushVector.new(50, 40*param, -50, -450+50*param)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param,
        :remnant => :player_rail
      )
    end
    
    mPieceLibrary.mCisternCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(-400, -20, 60, -300)
      ),
      :patrol_points => [
        MushVector.new(200, 200, 0, -500),
        MushVector.new(-200, 200, 0, -500)
        ],
      :ammo_count => 4,
      :ai_state => :patrol,
      :ai_state_msec => 10000,
      :weapon => :vendor_spawner
    )
  
    $currentLogic.mRemnant.mCreate(
      :item_type => :player_rail,
      :post => MushPost.new(
        :position => MushVector.new(1, 1, 0, -10)
      )
    )

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 2) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(3, 0 , 0, -20)
      )
    )
    
    if diff < 1
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(5, 1, 0, -40)
        )
      )
    end
 
    $currentLogic.mRemnant.mCreate(
      :item_type => :player_heavy_missile,
      :post => MushPost.new(
        :position => MushVector.new(7, 2, 0, -50)
      )
    )
          
    mStandardCosmos(28)
  end
  
  def mSpawn0
    diff = AdanaxisRuby.cGameDifficulty

    2.times do |param|
      ['blue', 'red',].each do |colour|
        mPieceLibrary.mLimescaleCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(0, ((colour == 'red')?400:-400), 0, -700) +
            MushTools.cRandomUnitVector * (100 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
    end

    MushGame.cVoicePlay('voice-E3-3') # 'Hostile import detected'
    return true
  end

  def mSpawn1
    diff = AdanaxisRuby.cGameDifficulty
          
    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-700,0,0,-200),
        :velocity => MushVector.new(0.5+0.2*diff, 0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(500,0,0,-200),
          MushVector.new(-500,0,0,-200)
          ],
      :ammo_count => 2+2*diff,
      :ai_state => :dormant,
      :ai_state_msec => 6000,
      :weapon => :vendor_spawner
    )
    
    mPieceLibrary.mVortexCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-500,0,0,-500)
      ),
      :spawned => true,
      :ai_state => :dormant,
      :ai_state_msec => 2000
    )
    
    MushGame.cVoicePlay('voice-E3-2') # 'Hostile import detected'

    return true
  end

  def mSpawn2
    MushTools.cRandomSeedSet(10)
    1.times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(600, 0, 0, -500) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :spawned => true,
          :ai_state => :dormant,
          :ai_state_msec => 12000
        )
    end
    
    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'

    return true
  end
end
