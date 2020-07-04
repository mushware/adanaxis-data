#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level26/space.rb
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
#%Header } COxopwFAW4CMRHkwL1J47g
# $Id: space.rb,v 1.4 2007/06/27 13:18:58 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/06/27 13:18:58  southa
# Debian packaging
#
# Revision 1.3  2007/06/27 12:58:17  southa
# Debian packaging
#
# Revision 1.2  2007/06/12 11:09:37  southa
# Level 28
#
# Revision 1.1  2007/06/08 16:23:04  southa
# Level 26
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level26 < AdanaxisSpace
  def initialize(inParams = {})
    super

    diff = AdanaxisRuby.cGameDifficulty

    20.times do |i|
      mTimeOnlySpawnAdd(:mWarehouseAdd, 30000+i*20000)
    end

    5.times do |i|
      mTimeOnlySpawnAdd(:mLimescaleAdd, 14000+i*20000) if diff > 0
      mTimeOnlySpawnAdd(:mCisternAdd, 16000+i*20000)
      mTimeOnlySpawnAdd(:mVendorAdd, 24000+i*20000) if diff > 1
    end

    mTimeOnlySpawnAdd(:mVortexAdd, 20000) if diff > 0
    mTimeOnlySpawnAdd(:mRailAdd, 40000) if diff > 1
    mTimeOnlySpawnAdd(:mVortexAdd, 60000) if diff > 1

    mTimeOnlySpawnAdd(:mSpawn0, 60000)
    mTimeOnlySpawnAdd(:mSpawn0, 120000)

    mIsBattleSet(true)
    mPrimarySet(PRIMARY_RED)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-except-for-this.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L26.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mDoorTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(26)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInYZPlane(Math::PI/2)
    MushTools.cRotationInXWPlane(Math::PI/2).mRotate(angPos)
    MushTools.cRotationInXYPlane(Math::PI/2).mRotate(angPos)

    1.times do |param|
      mPieceLibrary.mDoorCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -800),
          :angular_position => angPos,
          :angular_velocity => MushTools.cRotationInXYPlane(Math::PI / 1600)
        ),
        :is_primary => true
      )
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
        :item_type => :player_rail,
        :post => MushPost.new(
          :position => MushVector.new(7, 3, 2, -100-10*param)
        )
      )
    end

    3.times do |param|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_flak,
        :post => MushPost.new(
          :position => MushVector.new(10, 4, 4, -140-10*param)
        )
      )
    end

    mStandardCosmos(26)
  end

  def mSpawn0
    mPieceLibrary.mCisternCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(100, -20, 0, -1400)
      ),
      :patrol_points => [
        MushVector.new(-200, 200, 0, -1400),
        MushVector.new(200, 200, 0, -1400)
        ],
      :ammo_count => 6,
      :ai_state => :patrol,
      :ai_state_msec => 10000,
      :weapon => :attendant_spawner
    )
    return false
  end

  def mLimescaleAdd
    diff = AdanaxisRuby.cGameDifficulty

    mPieceLibrary.mLimescaleCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -800),
        :velocity => MushVector.new(0, 0, 0, 1.0),
        :angular_position => MushTools.cRotationInXWPlane(Math::PI)
      ),
      :spawned => true
    )

    return true
  end


  def mCisternAdd
    diff = AdanaxisRuby.cGameDifficulty

    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -800),
        :velocity => MushVector.new(0, 0, 0, 1.0),
        :angular_position => MushTools.cRotationInXWPlane(Math::PI)
      ),
      :patrol_points => [
        MushVector.new(-300, 0, 0, -700),
        MushVector.new(-300, 0, 0, -500),
        MushVector.new(300, 0, 0, -500),
        MushVector.new(300, 0, 0, -700)
        ],
      :ammo_count => 4 + 4 * diff,
      :ai_state => :patrol,
      :ai_state_msec => 3000,
      :weapon => :harpik_spawner,
      :spawned => true
    )

    return true
  end

  def mWarehouseAdd
    mPieceLibrary.mWarehouseCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -800),
        :velocity => MushVector.new(0, 0, 0, 1.0),
        :angular_position => MushTools.cRotationInXWPlane(Math::PI)
      ),
      :patrol_points => [
        MushVector.new(-300, 0, 0, -700),
        MushVector.new(-300, 0, 0, -500),
        MushVector.new(300, 0, 0, -500),
        MushVector.new(300, 0, 0, -700)
      ],
      :ai_state => :patrol,
      :ai_state_msec => 60000,
      :remnant => :player_nuclear,
      :spawned => true
    )

    return true
  end

  def mVendorAdd
    diff = AdanaxisRuby.cGameDifficulty

    mPieceLibrary.mVendorCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -800),
        :velocity => MushVector.new(0, 0, 0, 1.0),
        :angular_position => MushTools.cRotationInXWPlane(Math::PI)
      ),
      :spawned => true
    )

    return true
  end

  def mVortexAdd
    diff = AdanaxisRuby.cGameDifficulty

    mPieceLibrary.mVortexCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -800),
        :velocity => MushVector.new(0, 0, 0, 1.0),
        :angular_position => MushTools.cRotationInXWPlane(Math::PI)
      ),
      :spawned => true
    )

    return true
  end

  def mRailAdd
    mPieceLibrary.mRailCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -800),
        :velocity => MushVector.new(0, 0, 0, 1.0),
        :angular_position => MushTools.cRotationInXWPlane(Math::PI)
      ),
      :spawned => true
    )

    return true
  end

end
