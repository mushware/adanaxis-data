#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level2/space.rb
#
# Copyright: Andy Southgate 2002-2007, 2020
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##############################################################################
#%Header } EFwjkfljOHSfBp7AcjZjdQ
# $Id: space.rb,v 1.10 2007/06/27 13:18:57 southa Exp $
# $Log: space.rb,v $
# Revision 1.10  2007/06/27 13:18:57  southa
# Debian packaging
#
# Revision 1.9  2007/06/27 12:58:16  southa
# Debian packaging
#
# Revision 1.8  2007/05/12 14:20:48  southa
# Level 16
#
# Revision 1.7  2007/04/18 09:21:55  southa
# Header and level fixes
#
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
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L2.ogg|null:")
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
          MushTools.cRandomUnitVector * (20 + rand(100))

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
