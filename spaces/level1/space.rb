#%Header {
##############################################################################
#
# File adanaxis-data/spaces/level1/space.rb
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
#%Header } HK1smjGl6D4cec2lbUZfRA
# $Id: space.rb,v 1.9 2007/06/27 13:18:56 southa Exp $
# $Log: space.rb,v $
# Revision 1.9  2007/06/27 13:18:56  southa
# Debian packaging
#
# Revision 1.8  2007/06/27 12:58:14  southa
# Debian packaging
#
# Revision 1.7  2007/06/12 11:09:36  southa
# Level 28
#
# Revision 1.6  2007/04/18 09:21:55  southa
# Header and level fixes
#
# Revision 1.5  2007/04/17 11:37:40  southa
# Graphics fix
#
# Revision 1.4  2007/04/17 10:08:12  southa
# Voice work
#
# Revision 1.3  2007/04/16 18:50:58  southa
# Voice work
#
# Revision 1.2  2007/03/27 14:01:03  southa
# Attendant AI
#
# Revision 1.1  2007/03/23 12:27:35  southa
# Added levels and Cistern mesh
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level1 < AdanaxisSpace
  def initialize(inParams = {})
    super
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
    MushGame.cSoundDefine("voice-intro", "mush://waves/voice-L1.ogg|null:")
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
  end

  def mInitialPiecesCreate
    super
    (-2..2).each do |i|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(i * 50, -40, 0, -100-20*i.abs),
          :angular_position => MushTools.cRandomOrientation
        ),
        :waypoint => MushVector.new(i * 30, -0, i * 15, -250),
        :ai_state => :waypoint,
        :ai_state_msec => 15000
      )
    end

    mStandardCosmos(1)
  end
end
