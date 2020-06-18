#%Header {
##############################################################################
#
# File adanaxis-data/spaces/demoend1/space.rb
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
#%Header } RB9meNQ6vg3Uz1qJeqtdjg
# $Id: space.rb,v 1.2 2007/06/27 12:58:13 southa Exp $
# $Log: space.rb,v $
# Revision 1.2  2007/06/27 12:58:13  southa
# Debian packaging
#
# Revision 1.1  2007/06/12 11:09:36  southa
# Level 28
#
# Revision 1.1  2007/06/08 13:17:14  southa
# Level 25
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_demoend1 < AdanaxisSpace
  def initialize(inParams = {})
    super
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-adanaxistheme.ogg')
    mMusicAdd('game2', 'mushware-familiarisation.ogg')
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mFreshenerTex('red'))
  end

  def mInitialPiecesCreate
    super
    MushTools.cRandomSeedSet(25)
    diff = AdanaxisRuby.cGameDifficulty

    angVel = MushTools.cRotationInXYPlane(Math::PI / 1200);
    MushTools.cRotationInZWPlane(Math::PI / 1314).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 1575).mRotate(angVel);

    vel = MushVector.new(-0.05*(1+diff),0,0,0)
    angPos = MushTools.cRotationInXZPlane(Math::PI/2)

    mPieceLibrary.mFreshenerCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0,0,0,-1500),
        :angular_velocity => angVel
      ),
      :is_stealth => true
    )


    mStandardCosmos(1)
  end

end
