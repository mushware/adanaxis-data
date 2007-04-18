#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level2/space.rb
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
#%Header } drMlHpUBUzFxxKfTddXPFg
# $Id: space.rb,v 1.6 2007/04/17 21:16:33 southa Exp $
# $Log: space.rb,v $
# Revision 1.6  2007/04/17 21:16:33  southa
# Level work
#
# Revision 1.5  2007/04/17 10:08:12  southa
# Voice work
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
    MushGame.cVoicePlay('voice-E3-2') # 'Hostile import detected'
  end
end
