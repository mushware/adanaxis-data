#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level8/space.rb
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
#%Header } mmDxSdwqzPsJ4lPOi2WIag
# $Id: space.rb,v 1.4 2007/04/21 09:41:06 southa Exp $
# $Log: space.rb,v $
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
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L8.ogg")
  end
  
  def mPrecacheListBuild
    # super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red', 'blue'))
     mPrecacheListAdd(mPieceLibrary.mWarehouseTex('blue'))
    # mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(8)
    diff = AdanaxisRuby.cGameDifficulty

    # Blue convoy
    
    vel = MushVector.new(0,0,0,-0.05*(1+diff))
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)
  
    (-1..1).each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(10*param, -50+10*param, 0, -250-100*param),
          :velocity => vel,
          :angular_position => angPos
        ),
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
      :ammo_count => 30,
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
        :ammo_count => 20,
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