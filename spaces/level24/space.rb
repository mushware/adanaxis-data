#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level24/space.rb
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
#%Header } H8iKilC8i1iBPGP77v2a2g
# $Id: space.rb,v 1.3 2007/06/27 13:18:58 southa Exp $
# $Log: space.rb,v $
# Revision 1.3  2007/06/27 13:18:58  southa
# Debian packaging
#
# Revision 1.2  2007/06/27 12:58:17  southa
# Debian packaging
#
# Revision 1.1  2007/06/07 13:23:02  southa
# Level 24
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level24 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mIsBattleSet(true)
    mPermanentThrustSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L24.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mVortexTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(24)
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

    diff.times do |param|
      mPieceLibrary.mLimescaleCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100, -20, 0, -600-100*param),
          :angular_position => MushTools.cRandomOrientation
        ),
        :ai_state => :dormant,
        :ai_state_msec => 10000
      )
    end

    mPieceLibrary.mRailCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 400, -600) +
        MushTools.cRandomUnitVector * (20 + rand(100)),
        :angular_position => MushTools.cRandomOrientation
      ),
      :ai_state => :dormant,
      :ai_state_msec => 10000
    )

    1.times do |param|
      mPieceLibrary.mVortexCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(400, 0, 0, -800) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
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
        :position => MushVector.new(0, 0 , 0, -100)
      )
    )

    if diff < 1
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -110)
        )
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => :player_heavy_missile,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -120)
      )
    )

    mStandardCosmos(24)
  end

end
