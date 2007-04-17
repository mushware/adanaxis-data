#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level3/space.rb
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
#%Header } FlI7LfWSIQunDHuQw4VCOQ
# $Id: space.rb,v 1.1 2007/04/01 19:44:42 southa Exp $
# $Log: space.rb,v $
# Revision 1.1  2007/04/01 19:44:42  southa
# Created
#
# Revision 1.2  2007/03/24 14:06:28  southa
# Cistern AI
#
# Revision 1.1  2007/03/23 12:27:35  southa
# Added levels and Cistern mesh
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level3 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 42000) if AdanaxisRuby.cGameDifficulty > 0
    mTimeoutSpawnAdd(:mSpawn1, 63000) if AdanaxisRuby.cGameDifficulty > 1
    mTimeoutSpawnAdd(:mSpawn2, 80000) if AdanaxisRuby.cGameDifficulty > 0
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L3.ogg")
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red'))
  end
  
  def mCisternCreate(inRange, inOffset = MushVector.new(0,0,0,0))
    inRange.each do |i|
      patrolPoints = [
        MushVector.new(i * 50, 200, -i*50, -100),
        MushVector.new(i * 50, -200, 50, -100),
        MushVector.new(i * 50, -200, i*50, -500),
        MushVector.new(i * 50, 200, -50, -500),
      ]

      patrolPoints.map! { |vec| inOffset + vec }
    
      angPos = MushTools.cRotationInXZPlane(Math::PI/2)
      MushTools.cRotationInYWPlane(Math::PI/2).mRotate(angPos)
      
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(i * 50, -40, 0, -600-20*i.abs) + inOffset,
          :velocity => MushVector.new(0, 0.1, 0, 0),
          :angular_position => angPos
        ),
        :patrol_points => patrolPoints
      )
    end
  end
  
  def mInitialPiecesCreate
    super
    mCisternCreate(0..0)
    mStandardCosmos(3)
  end
  
  def mSpawn0
    mCisternCreate(-1..1, MushVector.new(0,0,0,-200))
    MushGame.cVoicePlay('voice-E3-1') # 'Hostile import detected'
    true
  end

  def mSpawn1
    mCisternCreate(-2..2, MushVector.new(0,0,0,-400))
    MushGame.cVoicePlay('voice-E3-2') # 'Hostile import detected'
    true
  end
  
  def mSpawn2
    (-1..1).each do |i|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_missile,
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -500-5*i)),
        :spawned => true
      )
    end
    MushGame.cNamedDialoguesAdd('^import1')
    false
  end
end
