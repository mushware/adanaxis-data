#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level23/space.rb
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
#%Header } 6rSOcA1Zjqa8eU6cskaE0w
# $Id: space.rb,v 1.3 2007/06/27 13:18:58 southa Exp $
# $Log: space.rb,v $
# Revision 1.3  2007/06/27 13:18:58  southa
# Debian packaging
#
# Revision 1.2  2007/06/27 12:58:17  southa
# Debian packaging
#
# Revision 1.1  2007/06/06 15:11:21  southa
# Level 23
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level23 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mIsBattleSet(true)
    mPrimarySet(PRIMARY_BLUE)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L23.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mFloaterTex('red'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('blue'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(23)
    diff = AdanaxisRuby.cGameDifficulty

    vel = MushVector.new(0,0,0,-0.02*(4+diff))
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)
    angVel = MushTools.cRotationInXYPlane(Math::PI / 240);
    MushTools.cRotationInZWPlane(Math::PI / 314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 575).mRotate(angVel);

    # Red mines

    [-1,1].each do |paramX|
      [-1,1].each do |paramY|
        [-3,-1,1].each do |paramW|
          mPieceLibrary.mFloaterCreate(
            :colour => 'red',
            :post => MushPost.new(
              :position => MushVector.new(50*paramX, -50+50*paramY, 50, -650+50*paramW),
              :angular_position => angPos,
              :angular_velocity => angVel
            ),
            :remnant => (diff < 1) ? :player_light_missile : :player_quad_cannon,
            :is_stealth => true
          )
        end
      end
    end

    4.times do |param|
      pos = MushVector.new(0, 0, 0, 300*param)
      MushTools.cRotationInXWPlane(Math::PI / 5).mRotate(pos)
      MushTools.cRotationInYZPlane(Math::PI / 3).mRotate(pos)
      pos += MushVector.new(0,80,-200,-500)
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => pos,
          :angular_velocity => angVel
        ),
        :is_jammer => true
      )

      mPieceLibrary.mFloaterCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0,0,0, -700+50*param),
          :angular_position => angPos,
          :angular_velocity => angVel
        ),
        :remnant => (diff < 1) ? :player_rail : :player_heavy_cannon,
        :is_stealth => true
      )
    end

    # Blue convoy

    (-1..1).each do |param1|
      (-1..1).each do |param2|
        pos = MushVector.new(10*param1+50*param2, -50+10*param1, 0, -250-100*param1)
        mPieceLibrary.mWarehouseCreate(
          :colour => 'blue',
          :post => MushPost.new(
            :position => pos,
            :velocity => vel,
            :angular_position => angPos
          ),
          :patrol_points => [
            pos + MushVector.new(0, 0, 0, -2000),
            pos
          ],
          :remnant => :player_rail,
          :ai_state => :patrol,
          :ai_state_msec => 60000,
          :is_primary => true
        )
      end
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(90*param, -50, 0, -300),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(300*param, -50, 0, -1000),
          MushVector.new(90*param, -50, 0, 0)
          ],
        :ammo_count => 10 - 2 * diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param,
        :weapon => :attendant_spawner
      )
    end

    if diff < 1
      [-1,1].each do |param|
        mPieceLibrary.mHarpikCreate(
          :colour => 'blue',
          :post => MushPost.new(
            :position => MushVector.new(30*param, -30, -50, -500),
            :velocity => vel,
            :angular_position => angPos
          ),
          :patrol_points => [
            MushVector.new(90*param, -50, 0, -1000),
            MushVector.new(30*param, -50, 0, 0)
            ],
          :ai_state => :patrol,
          :ai_state_msec => 8000+250*param
        )
      end
    end

    # Blue forces

    5*(3-diff).times do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(300-10*param, 300, 50, -600) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    if diff < 1
      mPieceLibrary.mCisternCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(200,200,100,-500)
        ),
        :patrol_points => [
            MushVector.new(200,200,100,-800),
            MushVector.new(200,200,100,-400)
            ],
        :ammo_count => 30,
        :ai_state => :dormant,
        :ai_state_msec => 2000,
        :weapon => :attendant_spawner
      )
    end

    (2-diff).times do |i|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_rail,
        :post => MushPost.new(
          :position => MushVector.new(-2, -2, 0, -50-10*i)
        )
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (diff < 1) ? :player_heavy_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(-4, 0, 0, -40)
      )
    )

    mStandardCosmos(23)
  end

  def mJammersEliminated
    mJammingSet(false)
    MushGame.cNamedDialoguesAdd('^unjammed')
  end
end
