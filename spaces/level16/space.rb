#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level16/space.rb
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
#%Header } 4UoOmDoJxK4joUFm/5ePgQ
# $Id: space.rb,v 1.2 2007/05/12 14:20:47 southa Exp $
# $Log: space.rb,v $
# Revision 1.2  2007/05/12 14:20:47  southa
# Level 16
#
# Revision 1.1  2007/05/10 14:06:26  southa
# Level 16 and retina spin
#
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level16 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mRetinaSpinSet(AdanaxisRuby.cGameDifficulty+1.0)
    mPermanentSpinSet(true)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-disturbed-sleep.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L16.ogg")
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
    mPrecacheListAdd(mPieceLibrary.mLimescaleTex('red'))
    mPrecacheListAdd(mPieceLibrary.mVendorTex('red'))
    mPrecacheListAdd(mPieceLibrary.mWarehouseTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(16)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);
  
    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)
  
    (-diff..diff).each do |param|
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200*param, 30, -100*param, -500),
          :angular_velocity => angVel
        )
      )
      mPieceLibrary.mFreshenerCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(200*param, 200, 100*param, -400),
          :angular_velocity => angVel
        )
      )
    end

    8.times do
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0,0,0,-300) +
          MushTools.cRandomUnitVector * (20 + rand(200)),
          :angular_position => MushTools.cRandomOrientation
        )
      )
    end

    diff.times do |param|
      mPieceLibrary.mVendorCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -300) +
          MushTools.cRandomUnitVector * (50 + rand((diff+0.5)*100)),
          :angular_position => MushTools.cRandomOrientation
        )
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
      mPieceLibrary.mWarehouseCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(-30, -200+100*param, -100, -150+150*param),
          :velocity => vel,
          :angular_position => angPos
        ),
        :patrol_points => [
          MushVector.new(-30, 200+100*param, -100, -350+150*param),
          MushVector.new(-30, 200+100*param, -100, -350+150*param)
          ],
        :ai_state => :patrol,
        :ai_state_msec => 8000+250*param,
        :remnant => :player_light_missile
      )
    end
    
    $currentLogic.mRemnant.mCreate(
      :item_type => (AdanaxisRuby.cGameDifficulty < 2) ? :player_light_missile : :player_heavy_cannon,
      :post => MushPost.new(
        :position => MushVector.new(6*diff, 6*diff, 6*diff, -20)
      )
    )
    
    mStandardCosmos(16)
  end
end
