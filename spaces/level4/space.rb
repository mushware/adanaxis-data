#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level4/space.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Commercial Software Licence version 1.2.  If not supplied with this software
# a copy of the licence can be obtained from Mushware Limited via
# http://www.mushware.com/.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } wE/Qn4CN09yXiKKazPP1eg
# $Id: space.rb,v 1.4 2007/03/26 16:31:36 southa Exp $
# $Log: space.rb,v $
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

class Adanaxis_level4 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 13000)
    mIsBattleSet(true)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-disturbed-sleep.ogg')
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
  end
  
  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(4)
    
    1.times do |param|
      ['red'].each do |colour|
        mPieceLibrary.mRailCreate(
          :colour => colour,
          :position => MushVector.new(0, 0, 0, -600)
        )
      end    
    end
    
    15.times do |param|
      ['blue'].each do |colour|
        pos = MushVector.new(0, 0, 0, -150) +
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
      :ammo_count => 15 + 10 * AdanaxisRuby.cGameDifficulty
    )
  end
end
