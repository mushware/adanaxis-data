#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level29/space.rb
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
#%Header } y7C3h2H2cz4dNDFcFYM0VQ
# $Id: space.rb,v 1.3 2007/06/27 13:18:58 southa Exp $
# $Log: space.rb,v $
# Revision 1.3  2007/06/27 13:18:58  southa
# Debian packaging
#
# Revision 1.2  2007/06/27 12:58:18  southa
# Debian packaging
#
# Revision 1.1  2007/06/13 14:08:44  southa
# Level 29
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level29 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mPrimarySet(PRIMARY_RED)
    mSpeedAugmentationSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-respiration.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L29.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(29)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(0,0,0,-10.0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (-1..1).each do |param1|
      (-1..1).each do |param2|
        mPieceLibrary.mWarehouseCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(100*param1+30*param2, -50, -50, -100*param2),
            :velocity => vel,
            :angular_position => angPos
          ),
          :patrol_points => [
            MushVector.new(100*param1+30*param2, 0, -50, -4000-100*param2),
            MushVector.new(100*param1+30*param2, 0, 50, -100*param2),
            ],
          :patrol_speed => 3.0,
          :patrol_acceleration => 0.04,
          :ai_state => :patrol,
          :ai_state_msec => 60000,
          :remnant => :player_rail,
          :is_primary => true
        )
      end
    end

    (3+diff).times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(0, 0, 0, -1700) +
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
            :position => MushVector.new(0, 0, 0, -1300) +
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
            :position => MushVector.new(((colour == 'red')?100:-100), 0, 0, -1500) +
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
            :position => MushVector.new(((colour == 'red')?300:-300), 200, 0, -1500) +
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
          :position => MushVector.new(50+100*param, -20, 0, -1400),
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

    if diff < 2
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_rail,
        :post => MushPost.new(
          :position => MushVector.new(1, 1, 0, -10)
        )
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(1, 1 , 0, -20)
      )
    )

    if diff < 1
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(1, 1, 0, -40)
        )
      )
    end

    mStandardCosmos(29)
  end
end
