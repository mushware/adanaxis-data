#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level22/space.rb
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
#%Header } JpHWk1rYgFVkL+wuG09Cjg
# $Id: space.rb,v 1.5 2007/06/27 13:18:57 southa Exp $
# $Log: space.rb,v $
# Revision 1.5  2007/06/27 13:18:57  southa
# Debian packaging
#
# Revision 1.4  2007/06/27 12:58:16  southa
# Debian packaging
#
# Revision 1.3  2007/06/06 12:24:13  southa
# Level 22
#
# Revision 1.2  2007/06/05 14:57:38  southa
# Level 22 work
#
# Revision 1.1  2007/06/02 15:56:57  southa
# Shader fix and prerelease work
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level22 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-disturbed-sleep.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L22.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mBleachTex('red'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('blue'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(22)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(0,0,0,-0.1)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    # Blue convoy
    (-1..1).each do |param1|
      (-1..1).each do |param2|
        pos = MushVector.new(-10*param1+50*param2, -50+10*param1, 0, -250-100*param1-20*param2.abs)
        mPieceLibrary.mWarehouseCreate(
          :colour => 'blue',
          :post => MushPost.new(
            :position => pos,
            :velocity => vel,
            :angular_position => angPos
          ),
          :patrol_points => [
            pos + MushVector.new(0, 0, 0, -10000)
          ],
          :ai_state => :patrol,
          :ai_state_msec => 30000,
          :remnant => :player_heavy_missile
        )
      end
    end

    [-1,1].each do |param|
      mPieceLibrary.mVendorCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(100*param, -50, 0, -300),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(200*param, 0, 0, -10000)
        ],
        :ai_state => :patrol,
        :ai_state_msec => 31000
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(100*param, -40, -20, -200),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(1000*param, -50, 0, -10000)
        ],
        :ai_state => :patrol,
        :ai_state_msec => 30000+200*param,
        :weapon => :harpik_spawner,
        :ammo_count => 15-5*diff
      )
    end

    2.times do |param|
      pos = MushVector.new(-10,-50,80,-250-100*param)
      mPieceLibrary.mRailCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => pos,
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          pos + MushVector.new(0, 0, 0, -10000)
        ],
        :patrol_speed => 0.1,
        :ai_state => :patrol,
        :ai_state_msec => 29000
      )
    end

    # Red forces

    4.times do |param|
      mPieceLibrary.mBleachCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(800, 100, -50, -300-300*param),
          :velocity => MushVector.new(0,0,0,0),
          :angular_position => angPos
        ),
        :ai_state => :dormant,
        :ai_state_msec => 3000+1000*param,
        :ammo_count => 1
      )
    end

    6.times do |param|
      ['red'].each do |colour|
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
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(400, 200, -50, -700-100*param),
          :angular_position => MushTools.cRandomOrientation
        ),
        :ai_state => :dormant,
        :ai_state_msec => 3000+1000*param
      )
    end


    $currentLogic.mRemnant.mCreate(
      :item_type => :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(0, -2, 0, -40)
      )
    )


    (3-diff).times do |i|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_missile,
        :post => MushPost.new(
          :position => MushVector.new(0, -2, 0, -20+2*i)
        )
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => :player_flush,
      :post => MushPost.new(
        :position => MushVector.new(0,-2, 0, -60)
      )
    )

    mStandardCosmos(22)
  end
end
