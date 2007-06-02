#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level21/space.rb
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
#%Header } VN2cbP6xgmWO1fbzkAqZ7Q
# $Id: space.rb,v 1.1 2007/05/29 13:25:57 southa Exp $
# $Log: space.rb,v $

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level21 < AdanaxisSpace
  def initialize(inParams = {})
    super
    
    mIsBattleSet(true)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L21.ogg")
  end
  
  def mPrecacheListBuild
    ### super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(21)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);
  
    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)
    
    (3+3*diff).times do |param|
      mPieceLibrary.mVendorCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -300) +
          MushTools.cRandomUnitVector * (50 + rand((diff+0.5)*100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end
    
    4.times do |param|
      mPieceLibrary.mFreshenerCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(200, -200, -100, -300-100*param),
          :angular_velocity => angVel
        ),
        :is_jammer => false,
        
      )
    end
    
    4.times do |param|
      ['blue', 'red', 'red'].each do |colour|
        mPieceLibrary.mHarpikCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(500, 0, 0, -500+((colour == 'red')?-200:200)) +
              MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
    end
    
    2.times do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(400, 200, -50, -700-100*param),
          :angular_position => MushTools.cRandomOrientation
        ),
        :ai_state => :dormant,
        :ai_state_msec => 3000
      )
    end
    
    mPieceLibrary.mCisternCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(1000, -20, 0, -1000),
        :velocity => vel,
        :angular_position => angPos
      ),
      :patrol_points => [
        MushVector.new(-200, 200, 0, -1000),
        MushVector.new(200, 200, 0, -1000)
        ],
      :ammo_count => 15,
      :ai_state => :patrol,
      :ai_state_msec => 10000
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
        :position => MushVector.new(7, 2, 0, -80)
      )
    )
          
    mStandardCosmos(21)
  end
end
