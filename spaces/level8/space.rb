#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level8/space.rb
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
#%Header } ROnUv598uTMe4gboN3eFQg
# $Id: space.rb,v 1.11 2007/06/27 13:18:59 southa Exp $
# $Log: space.rb,v $
# Revision 1.11  2007/06/27 13:18:59  southa
# Debian packaging
#
# Revision 1.10  2007/06/27 12:58:19  southa
# Debian packaging
#
# Revision 1.9  2007/06/14 18:55:11  southa
# Level and display tweaks
#
# Revision 1.8  2007/06/14 12:14:16  southa
# Level 30
#
# Revision 1.7  2007/06/12 13:36:22  southa
# Demo configuration
#
# Revision 1.6  2007/04/26 13:12:39  southa
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

class Adanaxis_level8 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 180000)
    mIsBattleSet(true)
    mPrimarySet(PRIMARY_BLUE)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L8.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(8)
    diff = AdanaxisRuby.cGameDifficulty

    # Blue convoy

    vel = MushVector.new(0,0,0,-0.05*(1+diff))
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (-2..2).each do |param|
      pos = MushVector.new(10*param, -50+10*param, 0, -250-100*param)
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
        :ai_state => :patrol,
        :ai_state_msec => 60000,
        :remnant => :player_heavy_missile,
        :is_primary => true
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(60*param, -50, 0, -300),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(60*param, -50, 0, -3000),
          MushVector.new(60*param, -50, 0, 0)
          ],
        :ammo_count => 10 - 2 * diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param
      )
    end

    (3-diff).times do |i|
      [-1,1].each do |param|
        mPieceLibrary.mHarpikCreate(
          :colour => 'blue',
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

    (-1..(diff+1)).each do |param|
      mPieceLibrary.mHarpikCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200+param*50, param.abs*20, param*40, -400-param.abs*40)
        ),
        :ai_state => :dormant,
        :ai_state_msec => 2000
      )
    end

    2.times do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-200, -200, 0, -300-100*param)
        ),
        :ai_state => :dormant,
        :ai_state_msec => 6000
      )
    end

    15.times do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-200-10*param, -100, -50, -600) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    diff.times do |param|
      mPieceLibrary.mHarpikCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200+10*param, 100, -1000, -600) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-50,-20,0,0),
        :velocity => MushVector.new(0, 0, 0, -1.0)
      ),
      :patrol_points => [
          MushVector.new(-50,-20,0,-1000),
          MushVector.new(-50,-20,0,-800)
          ],
      :ammo_count => 15,
      :ai_state => :dormant,
      :ai_state_msec => 6000,
      :weapon => :attendant_spawner
    )

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_heavy_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(-4, 0, 0, -40)
      )
    )

    $currentLogic.mRemnant.mCreate(
      :item_type => :player_flak,
      :post => MushPost.new(
        :position => MushVector.new(-4, 0, 0, -50)
      )
    )

    $currentLogic.mRemnant.mCreate(
      :item_type => :player_quad_cannon,
      :post => MushPost.new(
        :position => MushVector.new(-4, 0, 0, -60)
      )
    )

    mStandardCosmos(8)
  end

  def mSpawn0
    MushTools.cRandomSeedSet(8)
    diff = AdanaxisRuby.cGameDifficulty

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(50*param,20*param,0,-50),
          :velocity => MushVector.new(0, 0, 0, -1.0*(1+0.5*diff))
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(50*param,20*param,0,-1000),
            MushVector.new(50*param,20*param,0,-800)
            ],
        :ammo_count => 6,
        :ai_state => :dormant,
        :ai_state_msec => 12000,
        :weapon => :attendant_spawner
      )
    end

    diff.times do |i|
      [-1,1].each do |param|
        mPieceLibrary.mHarpikCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(80*param,20*param,0,-50+50*i),
            :velocity => MushVector.new(0, 0, 0, -1.0*(1+0.5*diff))
          ),
          :spawned => true,
          :ai_state => :dormant,
          :ai_state_msec => 12000
        )
      end
    end

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
  end
end
