#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level27/space.rb
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
#%Header } a4w1D4MdBeTsE9kZXbu8eA
# $Id: space.rb,v 1.3 2007/06/27 12:58:17 southa Exp $
# $Log: space.rb,v $
# Revision 1.3  2007/06/27 12:58:17  southa
# Debian packaging
#
# Revision 1.2  2007/06/12 11:09:37  southa
# Level 28
#
# Revision 1.1  2007/06/11 20:06:13  southa
# Compatibility fixes and level 27
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level27 < AdanaxisSpace
  def initialize(inParams = {})
    super

    mTimeoutSpawnAdd(:mSpawn0, 60000)

    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L27.ogg")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('blue'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mHarpikTex('red'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('blue'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(27)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    (-3..3).each do |param|
        mPieceLibrary.mRailCreate(
          :colour => 'blue',
          :post => MushPost.new(
            :position => MushVector.new(-30+100*param, -50-4*param, 20*param, -400-50*param.abs),
            :angular_position => MushTools.cRandomOrientation
          ),
          :ai_state => :dormant,
          :ai_state_msec => 40000+2000*param,
          :ammo_count => 0
        )
    end

    targNum=0
    (-3..3).each do |param|
      mPieceLibrary.mWarehouseCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(20*param, -20, -20, -100+20*param.abs),
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-300, 100*param, -400, -250+50*param),
          MushVector.new(300, 100*param, -400, -250+50*param)
          ],
        :ai_state => :seek,
        :ai_state_msec => 8000+250*param,
        :seek_speed => 0.05+0.025*diff,
        :seek_acceleration => 0.01,
        :target_id => "kr:#{targNum}",
        :target_types => "p,kb",
        :remnant => :player_base,
        :weapon => :khazi_resupply
      )
      targNum += 1
    end

    (-2..2).each do |param|
      mPieceLibrary.mRailCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-30+50*param, -20-4*param, 20*param, -1000-100*param.abs),
          :angular_position => MushTools.cRandomOrientation
        ),
        :ai_state => :dormant,
        :ai_state_msec => 20000+2000*param
      )
    end

    20.times do |param|
      mPieceLibrary.mAttendantCreate(
        :colour => 'blue',
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -700) +
            MushTools.cRandomUnitVector * (20 + rand(150))),
          :angular_position => MushTools.cRandomOrientation
      )
    end

    mPieceLibrary.mCisternCreate(
      :colour => 'blue',
      :post => MushPost.new(
        :position => MushVector.new(50, -200, 200, -700)
      ),
      :patrol_points => [
        MushVector.new(-200, 200, 0, -400),
        MushVector.new(200, 200, 0, -1000)
        ],
      :ammo_count => 10,
      :ai_state => :patrol,
      :ai_state_msec => 30000
    )

    1.times do |param|
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 50, -600),
          :angular_velocity => angVel
        )
      )
    end

    10.times do |param|
      mPieceLibrary.mHarpikCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0, 240+80*diff, 0, -100) +
            MushTools.cRandomUnitVector * (20 + rand(150)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(50, -200, 200, -100)
      ),
      :patrol_points => [
        MushVector.new(-200, 200, 0, -1000),
        MushVector.new(200, 200, 0, -1000)
        ],
      :ammo_count => 2+diff,
      :ai_state => :patrol,
      :ai_state_msec => 20000,
      :weapon => :limescale_spawner
    )

    $currentLogic.mRemnant.mCreate(
      :item_type => :player_rail,
      :post => MushPost.new(
        :position => MushVector.new(3, 0 , 0, -20)
      )
    )

    3.times do |param|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_flak,
        :post => MushPost.new(
          :position => MushVector.new(5, 1, 0, -40-3*param)
        )
      )
    end

    mStandardCosmos(27)
  end

  def mSpawn0
    diff = AdanaxisRuby.cGameDifficulty

    mPieceLibrary.mCisternCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(-300,0,0,100)
      ),
      :spawned => true,
      :patrol_points => [
          MushVector.new(500,0,0,-200),
          MushVector.new(-500,0,0,-200)
          ],
      :ammo_count => 4+diff,
      :ai_state => :dormant,
      :ai_state_msec => 2000,
      :weapon => :harpik_spawner
    )

    (1+diff).times do |param|
      mPieceLibrary.mVendorCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-100+100*param,0,0,200)
        ),
        :spawned => true
      )
    end

    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'

    return true
  end
end
