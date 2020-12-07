#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level10/space.rb
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
#%Header } FZILs3jv0SdGkzvUI3upmw
# $Id: space.rb,v 1.5 2007/06/27 13:18:56 southa Exp $
# $Log: space.rb,v $
# Revision 1.5  2007/06/27 13:18:56  southa
# Debian packaging
#
# Revision 1.4  2007/06/27 12:58:14  southa
# Debian packaging
#
# Revision 1.3  2007/06/14 22:24:27  southa
# Level and gameplay tweaks
#
# Revision 1.2  2007/05/03 18:00:33  southa
# Level 11
#
# Revision 1.1  2007/05/01 16:40:07  southa
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

class Adanaxis_level10 < AdanaxisSpace
  def initialize(inParams = {})
    super
    if AdanaxisRuby.cGameDifficulty > 1
      mTimeoutSpawnAdd(:mSpawn0, 60000)
    end
    mTimeoutSpawnAdd(:mSpawn1, 120000)

    mPrimarySet(PRIMARY_RED)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-disturbed-sleep.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L10.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(10)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (0..0).each do |param|
      freshPos = MushVector.new(150, 150, -100*param, -1500)
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => freshPos,
          :angular_velocity => angVel
        ),
        :is_primary => true
      )
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => freshPos * 0.9
        ),
        :patrol_points => [
          freshPos * 0.8,
          freshPos * 0.9
        ],
        :ammo_count => 4 + 4 * diff,
        :ai_state => :dormant,
        :ai_state_msec => 6000
      )
    end

    2.times do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200, 200, diff*200, -1300-100*param)
        ),
        :ai_state => :dormant,
        :ai_state_msec => 6000
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100*param, -20, 0, -650+100*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-1000, 50*param, 0, -650),
          MushVector.new(0, 50*param, 0, -650)
          ],
        :ammo_count => 2 + 2 * diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param
      )
    end

    (-4*diff..4*diff).each do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100*param, 100*param, 0, -450-200*param),
          :angular_position => angPos
        ),
        :ai_state => :evade,
        :ai_state_msec => 4000+250*param
      )
    end

    (-2*diff..2*diff).each do |param|
      mPieceLibrary.mHarpikCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(100*param, 100*param, 100*param, -350-200*param),
          :angular_position => angPos
        ),
        :ai_state => :evade,
        :ai_state_msec => 4000+250*param
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200+100*param, -20, -100, -350+150*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-1000+100*param, -20, -100, -350+150*param),
          MushVector.new(200+100*param, -20, -100, -350+150*param)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param,
        :remnant => case diff
                      when 0 then :player_heavy_missile
                      when 1 then :player_rail
                      else :player_light_missile
                    end
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_light_missile : :player_flak,
      :post => MushPost.new(
        :position => MushVector.new(4, 2, 0, -40)
      )
    )

    mStandardCosmos(10)
  end

    def mSpawn0
    MushTools.cRandomSeedSet(11)
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

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
  end

  def mSpawn1
    MushTools.cRandomSeedSet(11)
    diff = AdanaxisRuby.cGameDifficulty
    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(500,50*param,20*param,-1000),
          :velocity => MushVector.new(-0.2-0.2*diff, 0, 0, 0)
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(-500,50*param,20*param,-800),
            MushVector.new(500,50*param,20*param,-800)
            ],
        :ammo_count => 1+diff,
        :ai_state => :dormant,
        :ai_state_msec => 500,
        :weapon => :attendant_spawner
      )
    end
  end

end
