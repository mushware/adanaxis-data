#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level5/space.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } r6pSk2dJ6TbGKArdK+El0w
# $Id: space.rb,v 1.5 2007/06/27 13:18:59 southa Exp $
# $Log: space.rb,v $
# Revision 1.5  2007/06/27 13:18:59  southa
# Debian packaging
#
# Revision 1.4  2007/06/27 12:58:19  southa
# Debian packaging
#
# Revision 1.3  2007/04/18 09:21:56  southa
# Header and level fixes
#
# Revision 1.2  2007/04/17 21:16:33  southa
# Level work
#
# Revision 1.1  2007/03/28 14:45:46  southa
# Level and AI standoff
#
# Revision 1.1  2007/03/27 15:34:43  southa
# L4 and carrier ammo
#
# Revision 1.4  2007/03/26 16:31:36  southa
# L2 work
#
# Revision 1.3  2007/03/24 18:07:23  southa
# Level 3 work
#
# Revision 1.2  2007/03/24 14:06:28  southa
# Cistern AI
#
# Revision 1.1  2007/03/23 12:27:35  southa
# Added levels and Cistern mesh
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level5 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 15000)
    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-disturbed-sleep.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L5.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(4)

    (1+AdanaxisRuby.cGameDifficulty).times do |param|
      mPieceLibrary.mHarpikCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-30+60*param, 0, 0, -160+30*param),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    5.times do |param|
      ['blue'].each do |colour|
        pos = MushVector.new(0, 0, 0, -300) +
          MushTools.cRandomUnitVector * (20 + rand(100));

        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :position => pos
        )
      end
    end

    if AdanaxisRuby.cGameDifficulty < 1
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_light_missile,
        :post => MushPost.new(
          :position => MushVector.new(-2, 0, 0, -20)
        )
      )
    end

    mStandardCosmos(4)
  end

  def mSpawn0
    MushTools.cRandomSeedSet(4)
    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-100,-500,0,-500),
        :velocity => MushVector.new(0, 1.0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(-20,50,0,-700),
          MushVector.new(-20,-50,0,-500)
          ],
      :ammo_count => 25 + 15 * AdanaxisRuby.cGameDifficulty,
      :weapon => (AdanaxisRuby.cGameDifficulty > 1) ? :harpik_spawner : :attendant_spawner
    )

    mPieceLibrary.mCisternCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(100,500,0,-500),
        :velocity => MushVector.new(0, -1.0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(50,-50,0,-700),
          MushVector.new(50,50,0,-500)
          ],
      :ammo_count => 10 + 10 * AdanaxisRuby.cGameDifficulty
    )

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
  end
end
