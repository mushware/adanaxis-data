#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level6/space.rb
#
# Author Andy Southgate 2006-2007
#
# This file contains original work by Andy Southgate.  The author and his
# employer (Mushware Limited) irrevocably waive all of their copyright rights
# vested in this particular version of this file to the furthest extent
# permitted.  The author and Mushware Limited also irrevocably waive any and
# all of their intellectual property rights arising from said file and its
# creation that would otherwise restrict the rights of any party to use and/or
# distribute the use of, the techniques and methods used herein.  A written
# waiver can be obtained via http://www.mushware.com/.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } dqrpGHv21yM1TW5BwkiS2g
# $Id: space.rb,v 1.2 2007/04/16 08:41:07 southa Exp $
# $Log: space.rb,v $
# Revision 1.2  2007/04/16 08:41:07  southa
# Level and header mods
#
# Revision 1.1  2007/03/28 15:56:59  southa
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

class Adanaxis_level6 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 13000)
    mIsBattleSet(true)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-respiration.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L6.ogg")
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
  end
  
  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(6)
    diff = AdanaxisRuby.cGameDifficulty
    
    ((diff < 1)?1:2).times do |param|
      ['blue', 'red', 'red'].each do |colour|
        mPieceLibrary.mHarpikCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new((colour == 'red')?-100:100, 0, 0, -200) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
    end
    
    ((diff<1)?10:20).times do |param|
      ['blue', 'red', 'red'].each do |colour|
        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :post => MushPost.new(
            :position => MushVector.new((colour == 'red')?-100:100, 0, 0, -200) +
            MushTools.cRandomUnitVector * (20 + rand(100)),
            :angular_position => MushTools.cRandomOrientation
          )
        )
      end
    end

    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 1) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(0, 0, 0, -20)
      )
    )
    
    mStandardCosmos(6)
  end
  
  def mSpawn0
    MushTools.cRandomSeedSet(6)
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
