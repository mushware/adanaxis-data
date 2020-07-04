#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level12/space.rb
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
#%Header } 3QttbsghEvjR7F96ibHZyA
# $Id: space.rb,v 1.4 2007/06/27 13:18:56 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/06/27 13:18:56  southa
# Debian packaging
#
# Revision 1.3  2007/06/27 12:58:14  southa
# Debian packaging
#
# Revision 1.2  2007/06/14 22:24:27  southa
# Level and gameplay tweaks
#
# Revision 1.1  2007/05/08 15:28:14  southa
# Level 12
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level12 < AdanaxisSpace
  def initialize(inParams = {})
    super

    if AdanaxisRuby.cGameDifficulty > 1
      mTimeoutSpawnAdd(:mSpawn0, 20000)
    end
    if AdanaxisRuby.cGameDifficulty > 0
      mTimeoutSpawnAdd(:mSpawn1, 60000)
    end
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-respiration.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L12.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(12)
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
        ),
        :ai_state => :evade,
        :ai_state_msec => 8000+250*param
      )
    end

    diff.times do |param|
      mPieceLibrary.mLimescaleCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -700) +
          MushTools.cRandomUnitVector * (100 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
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
        :ammo_count => 1 + diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param,
        :weapon => (diff > 1) ? :harpik_spawner : :attendant_spawner
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 2) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -20)
      )
    )
    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -40)
      )
    )
    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_rail : :player_flak,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -60)
      )
    )

    mStandardCosmos(12)
  end

  def mSpawn0
    diff = AdanaxisRuby.cGameDifficulty
    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(300,0,0,-50),
        :velocity => MushVector.new(-0.5, 0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(-300,0,0,-50),
          MushVector.new(300,0,0,-50)
          ],
      :ammo_count => 2+diff,
      :ai_state => :dormant,
      :ai_state_msec => 10000,
      :weapon => :harpik_spawner
    )

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
  end

  def mSpawn1
    diff = AdanaxisRuby.cGameDifficulty

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-300,50*param,20*param,-200),
          :velocity => MushVector.new(-0.2-0.1*diff, 0, 0, 0)
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(-300,50*param,20*param,-200),
            MushVector.new(300,50*param,20*param,-200)
            ],
        :ammo_count => 1+diff,
        :ai_state => :dormant,
        :ai_state_msec => 15000,
        :weapon => :harpik_spawner
      )
    end
    MushGame.cVoicePlay('voice-E3-2') # 'Hostile import detected'
  end

end
