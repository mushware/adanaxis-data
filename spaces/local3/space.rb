#%Header {
##############################################################################
#
# File adanaxis-data/spaces/local3/space.rb
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
#%Header } PG5hC0ZO9QbudYSypb9URg
# $Id: space.rb,v 1.23 2007/06/27 12:58:20 southa Exp $
# $Log: space.rb,v $
# Revision 1.23  2007/06/27 12:58:20  southa
# Debian packaging
#
# Revision 1.22  2007/04/18 09:21:56  southa
# Header and level fixes
#
# Revision 1.21  2007/03/31 06:04:44  southa
# Header fix
#
# Revision 1.20  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.19  2007/03/09 11:29:12  southa
# Game end actions
#
# Revision 1.18  2007/02/08 17:55:13  southa
# Common routines in space generation
#
# Revision 1.17  2006/12/18 15:39:35  southa
# Palette changes
#
# Revision 1.16  2006/11/17 15:47:43  southa
# Ammo remnants
#
# Revision 1.15  2006/11/15 18:25:54  southa
# Khazi rails
#
# Revision 1.14  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.13  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.12  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.11  2006/10/18 13:22:08  southa
# World rendering
#
# Revision 1.10  2006/10/15 17:12:53  southa
# Scripted explosions
#
# Revision 1.9  2006/10/12 22:04:46  southa
# Collision events
#
# Revision 1.8  2006/10/09 16:00:15  southa
# Intern generation
#
# Revision 1.7  2006/10/06 14:48:18  southa
# Material animation
#
# Revision 1.6  2006/10/06 11:54:57  southa
# Scaled rendering
#
# Revision 1.5  2006/10/05 15:39:16  southa
# Explosion handling
#
# Revision 1.4  2006/10/04 14:54:33  southa
# AI tweaks
#
# Revision 1.3  2006/10/04 13:35:22  southa
# Selective targetting
#
# Revision 1.2  2006/10/03 14:06:50  southa
# Khazi and projectile creation
#
# Revision 1.1  2006/08/01 17:21:20  southa
# River demo
#
# Revision 1.16  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local3 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    MushGame.cSoundStreamDefine('game1', MushConfig.cGlobalWavesPath+'/mushware-respiration.ogg')
    @preCached = 0
  end

  def mPrecache
    super

    num = @preCached
    # Must still increment @preCached if cPrecache throws
    @preCached += 1
    case (num)
      when 20..29  then MushGLTexture.cPrecache("ember#{num-20}-tex")
      when 30..39  then MushGLTexture.cPrecache("star#{num-30}-tex")
      when 40..49  then MushGLTexture.cPrecache("flare#{num-40}-tex")
      when 50      then MushGLTexture.cPrecache("attendant-tex")
      when 51      then MushGLTexture.cPrecache("projectile1-tex")
      when 52      then MushGLTexture.cPrecache("projectile2-tex")
    end

    num
  end

  def mInitialPiecesCreate
    super
    50.times do |param|
      ['red', 'blue'].each do |colour|
        pos = MushVector.new((colour == 'red') ? -100 : 100, 0, 0, -400) +
          MushTools.cRandomUnitVector * (30 + rand(100));

        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :position => pos
        )
      end
    end

    4.times do |param|
      isRed = true
      thisType = isRed ? "kr" : "kb"
      targetTypes = isRed ? "kb+p,k,p" : "kr,k,p"

      pos = MushVector.new(isRed ? -200 : 200, 0, 0, -400) + MushTools.cRandomUnitVector * (30 + rand(100));
      khazi = AdanaxisPieceKhazi.cCreate(
        :mesh_name => "rail",
        :hit_points => 80.0,
        :post => MushPost.new(
          :position => pos
          ),
        :type => thisType,
        :target_types => targetTypes,
        :seek_speed => 0.01,
        :seek_acceleration => 0.003,
        :patrol_speed => 0.01,
        :patrol_acceleration => 0.003,

        :remnant => $currentLogic.mRemnant.mStandardRemnant(param),
        :weapon => :khazi_rail
      )
    end

    1000.times do |i|
      pos = MushTools.cRandomUnitVector * (7 + 20 * rand)
      world = AdanaxisWorld.new(
        :mesh_name => mMeshLibrary.mRandomCosmosName,
        :post => MushPost.new(
        :position => pos
        )
      )
    end

  end
end
