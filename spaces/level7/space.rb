#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level7/space.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.3, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } CN/AtDZjAIBjtYsLPBQz1g
# $Id: space.rb,v 1.4 2007/05/03 18:00:33 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2007/05/03 18:00:33  southa
# Level 11
#
# Revision 1.3  2007/04/18 20:08:39  southa
# Tweaks and fixes
#
# Revision 1.2  2007/04/18 09:21:56  southa
# Header and level fixes
#
# Revision 1.1  2007/04/17 21:16:34  southa
# Level work
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level7 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 180000)
    mIsBattleSet(true)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L7.ogg")
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
  end
  
  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(7)
    diff = AdanaxisRuby.cGameDifficulty
  
    ((-diff-1)..(diff+1)).each do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(param*50, param.abs*20, param*40, -400-param.abs*10),
          :angular_position => MushTools.cRotationInXWPlane(Math::PI)
        ),
        :ai_state => :dormant,
        :ai_state_msec => 80000 - 30000 * diff
      )  
    end
    
    (-15..15).each do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(20*param, 100, 0, -150) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end
    
    (-8..8).each do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(10*param, -100, -200, -600) +
          MushTools.cRandomUnitVector * (20 + rand(100)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(-4, 0, 0, -40)
      )
    )
    
    2.times do |i|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_quad_cannon,
        :post => MushPost.new(
          :position => MushVector.new(-4, 0, 0, -40-10*i)
        )
      )
    end
    
    mStandardCosmos(7)
  end
  
  def mSpawn0
    MushTools.cRandomSeedSet(7)
    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-100,-500,0,-200),
        :velocity => MushVector.new(0, 1.0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(-20,50,0,-400),
          MushVector.new(-20,-50,0,-200)
          ],
      :ammo_count => 25 + 15 * AdanaxisRuby.cGameDifficulty,
      :weapon => (AdanaxisRuby.cGameDifficulty > 1) ? :harpik_spawner : :attendant_spawner
    )
    
    mPieceLibrary.mCisternCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(100,500,0,-200),
        :velocity => MushVector.new(0, -1.0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(50,-50,0,-400),
          MushVector.new(50,50,0,-200)
          ],
      :ammo_count => 30 - 5 * AdanaxisRuby.cGameDifficulty
    )

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
  end
end
