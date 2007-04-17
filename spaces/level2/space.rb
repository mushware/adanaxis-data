#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level2/space.rb
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
#%Header } ki7f3zF4dsHAYDyMx/ZYpA
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

class Adanaxis_level2 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 30000) if AdanaxisRuby.cGameDifficulty < 1
    mIsBattleSet(true)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-disturbed-sleep.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L2.ogg")
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
  end
  
  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(2)
    6.times do |param|
      ['red', 'red', 'blue'].each do |colour|
        pos = MushVector.new(((colour == 'red') ? -90 : 90), 0, 0, -300) +
          MushTools.cRandomUnitVector * (20 + rand(100));
        
        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :position => pos
        )
      end
    end
    mStandardCosmos(2)
  end
  
  def mSpawn0
    MushTools.cRandomSeedSet(2)
    3.times do |param|
      ['blue'].each do |colour|
        pos = MushVector.new(((colour == 'red') ? -90 : 90), 0, 0, -500) +
          MushTools.cRandomUnitVector * (20 + rand(100));
        
        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :position => pos
        )
      end
    end
  end
end
