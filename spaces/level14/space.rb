#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level14/space.rb
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
#%Header } Waqa0lR5jK9SxVWI9wRGTg
# $Id: space.rb,v 1.4 2007/06/27 13:18:56 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/06/27 13:18:56  southa
# Debian packaging
#
# Revision 1.3  2007/06/27 12:58:15  southa
# Debian packaging
#
# Revision 1.2  2007/06/14 22:24:27  southa
# Level and gameplay tweaks
#
# Revision 1.1  2007/05/09 19:24:43  southa
# Level 14
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level14 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mTimeoutSpawnAdd(:mSpawn2, 20000)

    if AdanaxisRuby.cGameDifficulty > 0
      mTimeoutSpawnAdd(:mSpawn0, 30000)
      mTimeoutSpawnAdd(:mSpawn1, 60000)
    end
    mTimeoutSpawnAdd(:mSpawn2, 120000)

    mIsBattleSet(true)
    @m_jammerSpawnDone =  false
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L14.ogg|null:")
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
    MushTools.cRandomSeedSet(14)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (-diff..diff).each do |param|
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(150*param, 150, -100*param, -800),
          :angular_velocity => angVel
        )
      )
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(150*param, -350, -100*param, -800),
          :angular_velocity => angVel
        )
      )
    end

    8.times do |param|
      ['blue', 'red'].each do |colour|
        mPieceLibrary.mHarpikCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, -700+((colour == 'red')?-400:400)) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
    end

    (2+diff).times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, -1200) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 10000
        )
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100*param, -20, 0, -650+100*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-1000, 50*param, 0, -650),
          MushVector.new(0, 50*param, 0, -650)
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
          :position => MushVector.new(-30, -200+100*param, -100, -150+150*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-30, 200+100*param, -100, -350+150*param),
          MushVector.new(-30, -200+100*param, -100, -350+150*param)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param,
        :remnant => :player_heavy_missile
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 2) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(6, 6, 0, -20)
      )
    )

    if diff < 1
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(-6, -6, 0, -40)
        )
      )
    end

    mStandardCosmos(14)
  end

  def mSpawn0
    diff = AdanaxisRuby.cGameDifficulty
    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(500,0,0,-50),
        :velocity => MushVector.new(-1.0, 0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(-500,0,0,-50),
          MushVector.new(500,0,0,-50)
          ],
      :ammo_count => 2+4*diff,
      :ai_state => :dormant,
      :ai_state_msec => 2000,
      :weapon => :harpik_spawner
    )

    6.times do |param|
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

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-600,50*param,20*param,-200),
          :velocity => MushVector.new(0.5+0.2*diff, 0, 0, 0)
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(500,50*param,20*param,-200),
            MushVector.new(-500,50*param,20*param,-200)
            ],
        :ammo_count => 2+2*diff,
        :ai_state => :dormant,
        :ai_state_msec => 4000+1000*param,
        :weapon => :harpik_spawner
      )
    end

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

    MushGame.cVoicePlay('voice-E1-1') # 'Guided ordnance detected'
    return true
  end

  def mSpawn2
    MushTools.cRandomSeedSet(10)
    diff = AdanaxisRuby.cGameDifficulty
    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(500,50*param,20*param,-1000),
          :velocity => MushVector.new(-0.2-0.2*diff, 0, 0, 0)
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(-500,50*param,20*param,-800),
            MushVector.new(500,50*param,20*param,-800)
            ],
        :ammo_count => 1+diff,
        :ai_state => :dormant,
        :ai_state_msec => 500,
        :weapon => :attendant_spawner
      )
    end

    return false
  end

  def mJammersEliminated
    unless @m_jammerSpawnDone
      diff = AdanaxisRuby.cGameDifficulty
      (2+diff).times do |param|
          mPieceLibrary.mRailCreate(
            :colour => 'blue',
            :post => MushPost.new(
              :position => MushVector.new(0, 0, 0, -800) +
              MushTools.cRandomUnitVector * 800,
              :angular_position => MushTools.cRandomOrientation
            ),
            :ai_state => :dormant,
            :ai_state_msec => 4000
          )
      end
    end
    MushGame.cNamedDialoguesAdd('^unjammed1')
    @m_jammerSpawnDone = true
  end
end
