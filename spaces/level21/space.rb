#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level21/space.rb
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
#%Header } Iusc2j8pxyVEjOdw5BIawg
# $Id: space.rb,v 1.4 2007/06/27 13:18:57 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/06/27 13:18:57  southa
# Debian packaging
#
# Revision 1.3  2007/06/27 12:58:16  southa
# Debian packaging
#
# Revision 1.2  2007/06/05 12:15:14  southa
# Level 21
#
# Revision 1.1  2007/06/02 15:56:57  southa
# Shader fix and prerelease work
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level21 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mIsBattleSet(true)
    mJammingSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L21.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('red'))
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
        :is_jammer => true
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
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-400, -200, -50, -500-100*param),
          :angular_position => MushTools.cRandomOrientation
        ),
        :ai_state => :dormant,
        :ai_state_msec => 15000
      )
    end

    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-500, -200, -50, -500),
        :velocity => vel,
        :angular_position => angPos
      ),
      :patrol_points => [
        MushVector.new(-500, -200, -200, -1000),
        MushVector.new(-200, 0, 200, -1000),
        MushVector.new(-200, 0, 200, -500),
        MushVector.new(-500, -200, -200, -500)
        ],
      :ammo_count => 5+10*diff,
      :ai_state => :patrol,
      :ai_state_msec => 10000,
      :weapon => :vendor_spawner
    )

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
        :position => MushVector.new(-10, 0 , 0, -20)
      )
    )

    if diff < 1
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -40)
        )
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => :player_heavy_missile,
      :post => MushPost.new(
        :position => MushVector.new(10, 0, 0, -80)
      )
    )

    mStandardCosmos(21)
  end

  def mJammersEliminated
    mJammingSet(false)
    MushGame.cNamedDialoguesAdd('^unjammed')
  end
end
