#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level17/space.rb
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
#%Header } HJ6CxXNa4ZfxnccJPd3Wcw
# $Id: space.rb,v 1.2 2007/06/27 12:58:15 southa Exp $
# $Log: space.rb,v $
# Revision 1.2  2007/06/27 12:58:15  southa
# Debian packaging
#
# Revision 1.1  2007/05/24 15:13:50  southa
# Level 17
#
# Revision 1.1  2007/05/09 19:24:43  southa
# Level 14
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level17 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mTimeoutSpawnAdd(:mSpawn0, 80000) if AdanaxisRuby.cGameDifficulty > 0
    mTimeoutSpawnAdd(:mSpawn1, 60000) if AdanaxisRuby.cGameDifficulty > 1

    mIsBattleSet(false)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L17.ogg")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(17)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    8.times do |param|
      mPieceLibrary.mHarpikCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200, -50, 0, -400-40*param),
          :angular_position => angPos
        ),
        :ai_state => :dormant,
        :ai_state_msec => 10000
      )
    end

    (2+diff).times do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(200, 60, 0, -800-100*param),
            :angular_velocity => angVel
          ),
          :ai_state => :dormant,
          :ai_state_msec => 60000
        )
    end

    (2+diff).times do |param|
        mPieceLibrary.mLimescaleCreate(
          :colour => 'red',
          :post => MushPost.new(
            :position => MushVector.new(150, 60, 0, -800-100*param),
            :angular_velocity => angVel
          ),
          :ai_state => :dormant,
          :ai_state_msec => 60000
        )
    end

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200, -20, 0, -650+100*param),
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-1000, 50*param, 0, -650),
          MushVector.new(0, 50*param, 0, -650)
          ],
        :ammo_count => 5 + 5 * diff,
        :ai_state => :dormant,
        :ai_state_msec => 60000,
        :weapon => :harpik_spawner
      )
    end

    [-1,1].each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(220, 0, -100, -700+60*param),
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-30, 200+100*param, -100, -350+150*param),
          MushVector.new(-30, 200+100*param, -100, -350+150*param)
          ],
        :ai_state => :dormant,
        :ai_state_msec => 20000,
        :remnant => :player_rail
      )
    end

    (4-diff).times do |i|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_cannon,
        :post => MushPost.new(
          :position => MushVector.new(-1, -1, -1, -40-5*i)
        )
      )
    end

    mStandardCosmos(17)
  end

  def mSpawn0
    diff = AdanaxisRuby.cGameDifficulty
    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(500,0,0,-50),
        :velocity => MushVector.new(-1.0, 0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(-500,0,0,-50),
          MushVector.new(500,0,0,-50)
          ],
      :ammo_count => 2+4*diff,
      :ai_state => :dormant,
      :ai_state_msec => 2000,
      :weapon => :limescale_spawner
    )

    MushGame.cVoicePlay('voice-E3-3') # 'Hostile import detected'
    return true
  end

  def mSpawn1
    diff = AdanaxisRuby.cGameDifficulty

    [-1,1].each do |param|
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-600,50*param,20*param,-200),
          :velocity => MushVector.new(0.5+0.2*diff, 0, 0, 0)
        ),
        :spawned => true,
        :patrol_points => [
            MushVector.new(500,50*param,20*param,-200),
            MushVector.new(-500,50*param,20*param,-200)
            ],
        :ammo_count => 2+2*diff,
        :ai_state => :dormant,
        :ai_state_msec => 4000+1000*param,
        :weapon => :harpik_spawner
      )
    end

    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-700,0,0,-200),
        :velocity => MushVector.new(0.5+0.2*diff, 0, 0, 0)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(500,0,0,-200),
          MushVector.new(-500,0,0,-200)
          ],
      :ammo_count => 2+2*diff,
      :ai_state => :dormant,
      :ai_state_msec => 6000,
      :weapon => :vendor_spawner
    )

    MushGame.cVoicePlay('voice-E1-1') # 'Guided ordnance detected'
    return true
  end
end
