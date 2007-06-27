#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level19/space.rb
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
#%Header } 1wkoB/N29VT5x+SykwmO0A
# $Id: space.rb,v 1.4 2007/06/27 12:58:16 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/06/27 12:58:16  southa
# Debian packaging
#
# Revision 1.3  2007/06/12 11:09:36  southa
# Level 28
#
# Revision 1.2  2007/05/29 13:25:57  southa
# Level 20
#
# Revision 1.1  2007/05/24 16:59:43  southa
# Level 19
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level19 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mTimeoutSpawnAdd(:mSpawn0, 20000) if AdanaxisRuby.cGameDifficulty > 0
    mTimeoutSpawnAdd(:mSpawn1, 60000) if AdanaxisRuby.cGameDifficulty > 1

    mTimeOnlySpawnAdd(:mSpawn2, 90000)
    mTimeOnlySpawnAdd(:mSpawn3, 120000)

    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L19.ogg")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(19)
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
          :position => MushVector.new(20, 20, -100, -800),
          :angular_velocity => angVel
        )
      )
    end

    (2+diff).times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, -600) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 30000
        )
    end

    4.times do |param|
      ['blue', 'red'].each do |colour|
        mPieceLibrary.mHarpikCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(300, 0, 0, -500+((colour == 'red')?-200:200)) +
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
          :position => MushVector.new(100*param, -20, 0, -250+100*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-200, 50*param, 0, -250),
          MushVector.new(200, 50*param, 0, -250)
          ],
        :ammo_count => 2 + 2 * diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(50, 100*param, -400, -250+50*param),
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-300, 100*param, -400, -250+50*param),
          MushVector.new(300, 100*param, -400, -250+50*param)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param,
        :remnant => :player_rail
      )
    end

    mPieceLibrary.mCisternCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(100, -20, 0, -1400),
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


    mStandardCosmos(19)
  end

  def mSpawn0
    diff = AdanaxisRuby.cGameDifficulty

    2.times do |param|
      ['blue', 'red',].each do |colour|
        mPieceLibrary.mLimescaleCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(-400, 0, 0, -700+((colour == 'red')?-400:400)) +
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
    MushGame.cVoicePlay('voice-E3-2') # 'Hostile import detected'

    return true
  end

  def mSpawn2
    MushGame.cVoicePlay('voice-E6-1') # 'Caution is advised'
    MushGame.cNamedDialoguesAdd('^eta')
    return false
  end

  def mSpawn3
    MushTools.cRandomSeedSet(10)
    8.times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, -1200) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :spawned => true,
          :ai_state => :dormant,
          :ai_state_msec => 10000
        )
    end

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
    MushGame.cNamedDialoguesAdd('^reinforce')

    return true
  end
end
