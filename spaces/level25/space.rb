#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level25/space.rb
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
#%Header } ZivN8a2GxPE7afcjjEO4SA
# $Id: space.rb,v 1.4 2007/06/27 13:18:58 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/06/27 13:18:58  southa
# Debian packaging
#
# Revision 1.3  2007/06/27 12:58:17  southa
# Debian packaging
#
# Revision 1.2  2007/06/12 11:09:36  southa
# Level 28
#
# Revision 1.1  2007/06/08 13:17:14  southa
# Level 25
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level25 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mTimeoutSpawnAdd(:mSpawn0, 40000)
    mTimeoutSpawnAdd(:mSpawn1, 60000) if AdanaxisRuby.cGameDifficulty > 1
    mTimeoutSpawnAdd(:mSpawn2, 100000)

    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-except-for-this.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L25.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(25)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    2.times do |param|
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200, 100, -400+800*param, -800),
          :angular_velocity => angVel
        )
      )
    end

    (10+diff).times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(100, 0, 0, -700) +
            MushTools.cRandomUnitVector * (20 + rand(200)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 10000+200*param
        )
    end

    8.times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'blue',
          :post => MushPost.new(
            :position => MushVector.new(50, 0, 0, -200) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 100+200*param
        )
    end

    12.times do |param|
      ['blue', 'red'].each do |colour|
        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(200, 0, 0, -500+((colour == 'red')?-200:200)) +
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
            :position => MushVector.new(200, 0, 0, -500+((colour == 'red')?-200:200)) +
            MushTools.cRandomUnitVector * (120 + rand(100)),
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
        :ai_state_msec => 10000+250*param,
        :weapon => :harpik_spawner
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(50, 100*param, 200, -250+50*param),
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
      :ammo_count => 10,
      :ai_state => :patrol,
      :ai_state_msec => 10000,
      :weapon => :harpik_spawner
    )

    3.times do |param|
      mPieceLibrary.mVendorCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(-200, -20, -200, -400-100*param),
          :velocity => vel,
          :angular_position => angPos
        )
      )
    end

    3.times do |param|
      mPieceLibrary.mLimescaleCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(-400, 0, 0, -1000) +
          MushTools.cRandomUnitVector * (100 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    if diff < 1
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_missile,
        :post => MushPost.new(
          :position => MushVector.new(5, 1, 0, -20)
        )
      )
    end

    2.times do |param|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(7, 2, 0, -30-10*param)
        )
      )
    end

    1.times do |param|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_light_missile,
        :post => MushPost.new(
          :position => MushVector.new(4, 6, 0, -60-10*param)
        )
      )
    end

    (3-diff).times do |param|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_rail,
        :post => MushPost.new(
          :position => MushVector.new(3, 0, 12, -100-10*param)
        )
      )
    end

    3.times do |param|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_flak,
        :post => MushPost.new(
          :position => MushVector.new(3, 0, 12, -140-10*param)
        )
      )
    end

    mStandardCosmos(25)
  end

  def mSpawn0
    diff = AdanaxisRuby.cGameDifficulty

    12.times do |param|
      ['blue', 'red',].each do |colour|
        mPieceLibrary.mHarpikCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, ((colour == 'red')?-400:-900)) +
            MushTools.cRandomUnitVector * (100 + rand(200)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :spawned => true
        )
      end
    end

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
    return true
  end


  def mSpawn1
    diff = AdanaxisRuby.cGameDifficulty

    2.times do |param|
      ['blue', 'red', 'red'].each do |colour|
        mPieceLibrary.mLimescaleCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new(-400, 0, 0, -700+((colour == 'red')?-400:400)) +
            MushTools.cRandomUnitVector * (100 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          ),
          :spawned => true
        )
      end
    end

    MushGame.cVoicePlay('voice-E3-3') # 'Hostile import detected'
    return true
  end

  def mSpawn2
    diff = AdanaxisRuby.cGameDifficulty

    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-300,0,0,-200),
        :velocity => MushVector.new(0, 0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(500,0,0,-200),
          MushVector.new(-500,0,0,-200)
          ],
      :ammo_count => 6+4*diff,
      :ai_state => :dormant,
      :ai_state_msec => 2000,
      :weapon => :vendor_spawner
    )

    (4+2*diff).times do |param|
        mPieceLibrary.mVendorCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-100,0,0,-100-50*param)
      ),
      :spawned => true
    )
    end

    MushGame.cVoicePlay('voice-E3-2') # 'Hostile import detected'

    return true
  end

end
