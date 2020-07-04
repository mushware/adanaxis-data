#%Header {
##############################################################################
#
# File adanaxis-data/spaces/local2/space.rb
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
#%Header } P+x69DIBVONc9cMYxJKpyg
# $Id: space.rb,v 1.21 2007/06/27 12:58:20 southa Exp $
# $Log: space.rb,v $
# Revision 1.21  2007/06/27 12:58:20  southa
# Debian packaging
#
# Revision 1.20  2007/04/18 09:21:56  southa
# Header and level fixes
#
# Revision 1.19  2007/03/31 06:04:44  southa
# Header fix
#
# Revision 1.18  2007/03/13 18:21:36  southa
# Scanner jamming
#
# Revision 1.17  2007/03/09 11:29:12  southa
# Game end actions
#
# Revision 1.16  2007/03/08 18:38:14  southa
# Level progression
#
# Revision 1.15  2007/03/07 16:59:43  southa
# Khazi spawning and level ends
#
# Revision 1.14  2007/03/07 11:29:23  southa
# Level permission
#
# Revision 1.13  2007/03/06 21:05:17  southa
# Level work
#
# Revision 1.12  2007/02/08 17:55:13  southa
# Common routines in space generation
#
# Revision 1.11  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.10  2006/10/09 16:00:15  southa
# Intern generation
#
# Revision 1.9  2006/10/06 14:48:17  southa
# Material animation
#
# Revision 1.8  2006/10/03 14:06:50  southa
# Khazi and projectile creation
#
# Revision 1.7  2006/08/02 15:41:46  southa
# Prerelease work
#
# Revision 1.6  2006/08/01 23:21:49  southa
# Rendering demo content
#
# Revision 1.5  2006/08/01 17:21:19  southa
# River demo
#
# Revision 1.4  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local2 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mSpawnAdd(:mSpawn0)
  end

  def mLoad(game)
    mLoadStandard(game)
    MushGame.cSoundStreamDefine('game1', MushConfig.cGlobalWavesPath+'/mushware-except-for-this.ogg')
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
        :waypoint_msec => 15000,
        :ai_state => :waypoint_timed
      )
    end

    mStandardCosmos(2)
  end

  def mSpawn0
    (-1..1).each do |i|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(i * 50, -40, 0, -100-20*i.abs),
          :angular_position => MushTools.cRandomOrientation
        ),
        :waypoint => MushVector.new(i * 30, -0, i * 15, -250),
        :waypoint_msec => 15000,
        :ai_state => :waypoint_timed,
        :spawned => true
      )
    end
    return true
  end
end
