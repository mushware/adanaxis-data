#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level9/space.rb
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
#%Header } k/f0PXwAKospBFctSR80KA
# $Id: space.rb,v 1.5 2007/06/27 13:18:59 southa Exp $
# $Log: space.rb,v $
# Revision 1.5  2007/06/27 13:18:59  southa
# Debian packaging
#
# Revision 1.4  2007/06/27 12:58:19  southa
# Debian packaging
#
# Revision 1.3  2007/05/01 16:40:07  southa
# Level 10
#
# Revision 1.2  2007/04/26 16:22:41  southa
# Level 9
#
# Revision 1.1  2007/04/26 13:12:40  southa
# Limescale and level 9
#
# Revision 1.5  2007/04/21 18:05:47  southa
# Level 8
#
# Revision 1.4  2007/04/21 09:41:06  southa
# Level work
#
# Revision 1.3  2007/04/20 19:28:09  southa
# Level 8 work
#
# Revision 1.2  2007/04/20 12:07:08  southa
# Khazi Warehouse and level 8
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level9 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 180000)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-respiration.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L9.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(9)
    diff = AdanaxisRuby.cGameDifficulty

    # Red convoy

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (-diff..diff).each do |param|
      mPieceLibrary.mLimescaleCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(10*param.abs, -20, -100*param, -350-100*param),
          :velocity => vel,
          :angular_position => angPos
        )
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100*param, -20, 0, -350+100*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-1000, 50*param, 0, -350),
          MushVector.new(0, 50*param, 0, -350)
          ],
        :ammo_count => 2 + 2 * diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mHarpikCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100*param, -20, 0, -350+200*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-1000, 30*param, -50, 0),
          MushVector.new(0, 30*param, -50, 0)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100*param, -20, 0, -350+150*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-1000, 30*param, -50, 0),
          MushVector.new(0, 30*param, -50, 0)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param,
        :remnant => (AdanaxisRuby.cGameDifficulty < 2) ? :player_light_missile : :player_heavy_cannon
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(4, 2, 0, -40)
      )
    )

    mStandardCosmos(9)
  end

  def mSpawn0
    MushTools.cRandomSeedSet(9)
    diff = AdanaxisRuby.cGameDifficulty

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-50,50*param,20*param,0),
          :velocity => MushVector.new(-0.5-0.2*diff, 0, 0, 0)
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(-1000,50*param,20*param,0),
            MushVector.new(-800,50*param,20*param,0)
            ],
        :ammo_count => 1+diff,
        :ai_state => :dormant,
        :ai_state_msec => 4000,
        :weapon => :limescale_spawner
      )
    end

    diff.times do |i|
      [-1,1].each do |param|
        mPieceLibrary.mHarpikCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(-50+50*i,80*param,20*param,0),
            :velocity => MushVector.new(-0.5-0.2*diff, 0, 0, 0)
          ),
          :spawned => true,
          :ai_state => :dormant,
          :ai_state_msec => 6000
        )
      end
    end

    MushGame.cVoicePlay('voice-E3-3') # 'Hostile import detected'
  end
end
