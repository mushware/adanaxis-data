#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level18/space.rb
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
#%Header } B8udC/POW8A7Yjuc3cdsGg
# $Id: space.rb,v 1.6 2007/06/27 13:18:57 southa Exp $
# $Log: space.rb,v $
# Revision 1.6  2007/06/27 13:18:57  southa
# Debian packaging
#
# Revision 1.5  2007/06/27 12:58:15  southa
# Debian packaging
#
# Revision 1.4  2007/05/23 19:15:00  southa
# Level 18
#
# Revision 1.3  2007/05/22 16:44:59  southa
# Level 18
#
# Revision 1.2  2007/05/21 17:04:42  southa
# Player effectors
#
# Revision 1.1  2007/05/21 13:32:52  southa
# Flush weapon
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level18 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L18.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mVortexTex('red'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(18)
    diff = AdanaxisRuby.cGameDifficulty

    # Red forces

    vel = MushVector.new(0,0,0,-0.05*(1+diff))
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (0..2+diff).each do |param1|
        mPieceLibrary.mVortexCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(100*param1, -300+10*param1, 0, -250-100*param1),
            :velocity => vel,
            :angular_position => angPos
          ),
          :ai_state => :evade,
          :ai_state_msec => 10000+1000*param1
        )
    end

    diff.times do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(400, 400, 100, -800-100*param)
        ),
        :ai_state => :dormant,
        :ai_state_msec => 6000
      )
    end

    3.times do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0-10*param, 0, 0, -200) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
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

    (-10..10).each do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(10*param, 0, 50, -400) +
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

    $currentLogic.mRemnant.mCreate(
      :item_type => (diff < 1) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(-4, 0, 0, -40)
      )
    )

    $currentLogic.mRemnant.mCreate(
      :item_type => (diff < 2) ? :player_quad_cannon : :player_base,
      :post => MushPost.new(
        :position => MushVector.new(-4, 0, 0, -50)
      )
    )

    mStandardCosmos(18)
  end
end
