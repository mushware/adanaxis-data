#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level11/space.rb
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
#%Header } WD6Ccv7m3BLklnIHhR3XMA
# $Id: space.rb,v 1.3 2007/06/27 13:18:56 southa Exp $
# $Log: space.rb,v $
# Revision 1.3  2007/06/27 13:18:56  southa
# Debian packaging
#
# Revision 1.2  2007/06/27 12:58:14  southa
# Debian packaging
#
# Revision 1.1  2007/05/03 18:00:33  southa
# Level 11
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level11 < AdanaxisSpace
  def initialize(inParams = {})
    super

    if AdanaxisRuby.cGameDifficulty > 0
      mTimeoutSpawnAdd(:mSpawn0, 20000)
    end
    if AdanaxisRuby.cGameDifficulty > 1
      mTimeoutSpawnAdd(:mSpawn1, 60000)
    end
    mTimeoutSpawnAdd(:mSpawn2, 120000)

    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L11.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(11)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

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

    5.times do |param|
      ['blue', 'red'].each do |colour|
        mPieceLibrary.mRailCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, -700+((colour == 'red')?-500:500)) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 10000
        )
      end
    end

    6.times do |param|
      ['blue', 'red',].each do |colour|
        mPieceLibrary.mLimescaleCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, -700+((colour == 'red')?-400:400)) +
            MushTools.cRandomUnitVector * (100 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
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
          MushVector.new(-30, 200+100*param, -100, -350+150*param)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param,
        :remnant => :player_heavy_missile
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 2) ? :player_heavy_missile : :player_light_missile,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -20)
      )
    )
    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_heavy_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -40)
      )
    )
    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 3) ? :player_rail : :player_flak,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -60)
      )
    )
    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_heavy_missile : :player_light_missile,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -80)
      )
    )

    mStandardCosmos(11)
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

    MushGame.cVoicePlay('voice-E3-3') # 'Hostile import detected'
  end

  def mSpawn1
    diff = AdanaxisRuby.cGameDifficulty

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-500,50*param,20*param,-200),
          :velocity => MushVector.new(-0.5-0.2*diff, 0, 0, 0)
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(-500,50*param,20*param,-200),
            MushVector.new(500,50*param,20*param,-200)
            ],
        :ammo_count => 1+diff,
        :ai_state => :dormant,
        :ai_state_msec => 4000,
        :weapon => :attendant_spawner
      )
    end
    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
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
  end

end
