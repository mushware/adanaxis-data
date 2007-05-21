#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level18/space.rb
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
#%Header } QHuBwU97CjDbl6vwXxpUvA
# $Id: space.rb,v 1.1 2007/05/09 14:56:49 southa Exp $
# $Log: space.rb,v $

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level18 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mIsBattleSet(false)
    mPrimarySet(PRIMARY_RED)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L18.ogg")
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(18)
    diff = AdanaxisRuby.cGameDifficulty

    # Red convoy

    vel = MushVector.new(0,0,0,-0.05*(1+diff))
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)
  
    (-1..1).each do |param1|
      (-1..1).each do |param2|
        mPieceLibrary.mWarehouseCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(10*param1+50*param2, -50+10*param1, 0, -250-100*param1),
            :velocity => vel,
            :angular_position => angPos
          ),
          :remnant => (diff < 1) ? :player_light_missile : :player_quad_cannon,
          :is_primary => true
        )
      end
    end
    
    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(90*param, -50, 0, -300),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(90*param, -50, 0, -3000),
          MushVector.new(90*param, -50, 0, 0)
          ],
        :ammo_count => 10 - 2 * diff,
        :ai_state => :patrol,
        :ai_state_msec => 10000+250*param,
        :weapon => case diff
                    when 0: :attendant_spawner
                    when 1: :harpik_spawner
                    else :limescale_spawner
                  end,
        :is_primary => true
      )
    end
  
    (3-diff).times do |i|
      [-1,1].each do |param|
        mPieceLibrary.mHarpikCreate(
          :colour => 'red',
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
    
    4.times do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(400, 400, 100, -800-100*param)
        ),
        :ai_state => :dormant,
        :ai_state_msec => 6000
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
    
    if diff < 2
      $currentLogic.mRemnant.mCreate(
        :item_type => (diff < 1) ? :player_heavy_missile : :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(-4, 0, 0, -40)
        )
      )
    end
    
    mStandardCosmos(18)
  end
end
