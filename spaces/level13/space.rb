#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level13/space.rb
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
#%Header } CoQ2s7uHBnm6lsWPSSmHTg
# $Id: space.rb,v 1.4 2007/06/27 13:18:56 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/06/27 13:18:56  southa
# Debian packaging
#
# Revision 1.3  2007/06/27 12:58:14  southa
# Debian packaging
#
# Revision 1.2  2007/06/11 20:06:12  southa
# Compatibility fixes and level 27
#
# Revision 1.1  2007/05/09 14:56:49  southa
# Level 13
#
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level13 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mIsBattleSet(false)
    mPrimarySet(PRIMARY_RED)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L13.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(13)
    diff = AdanaxisRuby.cGameDifficulty

    # Red convoy

    vel = MushVector.new(0,0,0,-0.05*(1+diff))
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (-1..1).each do |param1|
      (-1..1).each do |param2|
        pos = MushVector.new(10*param1+50*param2, -50+10*param1, 0, -250-100*param1)
        mPieceLibrary.mWarehouseCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => pos,
            :velocity => vel,
            :angular_position => angPos
          ),
          :patrol_points => [
            pos + MushVector.new(0, 0, 0, -2000),
            pos
          ],
          :remnant => (diff < 1) ? :player_light_missile : :player_quad_cannon,
          :ai_state => :patrol,
          :ai_state_msec => 60000,
          :is_primary => true
        )
      end
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(90*param, -50, 0, -300),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(90*param, -50, 0, -3000),
          MushVector.new(90*param, -50, 0, 0)
          ],
        :ammo_count => 10 - 2 * diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param,
        :weapon => case diff
                    when 0: :attendant_spawner
                    when 1: :harpik_spawner
                    else :limescale_spawner
                  end,
        :is_primary => true
      )
    end

    (3-diff).times do |i|
      [-1,1].each do |param|
        mPieceLibrary.mHarpikCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(30*param*(i+1), -30, 0, -500+100*i),
            :velocity => vel,
            :angular_position => angPos
          ),
          :patrol_points => [
            MushVector.new(30*param, -50, 0, -3000),
            MushVector.new(30*param, -50, 0, 0)
            ],
          :ai_state => :patrol,
          :ai_state_msec => 8000+250*param
        )
      end
    end

    # Red forces

    4.times do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(400, 400, 100, -800-100*param)
        ),
        :ai_state => :dormant,
        :ai_state_msec => 6000
      )
    end

    # Blue forces

    15.times do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(300-10*param, 300, 50, -600) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

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

    if diff < 2
      $currentLogic.mRemnant.mCreate(
        :item_type => (diff < 1) ? :player_heavy_missile : :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(-4, 0, 0, -40)
        )
      )
    end

    mStandardCosmos(13)
  end
end
