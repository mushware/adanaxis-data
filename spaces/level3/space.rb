#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level3/space.rb
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
#%Header } fPFAGDRoK0rto2ebZgCwUQ
# $Id: space.rb,v 1.5 2007/06/27 13:18:59 southa Exp $
# $Log: space.rb,v $
# Revision 1.5  2007/06/27 13:18:59  southa
# Debian packaging
#
# Revision 1.4  2007/06/27 12:58:18  southa
# Debian packaging
#
# Revision 1.3  2007/04/18 09:21:55  southa
# Header and level fixes
#
# Revision 1.2  2007/04/17 21:16:33  southa
# Level work
#
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
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L3.ogg|null:")
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
