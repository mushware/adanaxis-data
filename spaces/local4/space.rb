#%Header {
##############################################################################
#
# File adanaxis-data/spaces/local4/space.rb
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
#%Header } xYOtRyS+UquBtvLbHWiK9Q
# $Id: space.rb,v 1.9 2007/06/27 12:58:20 southa Exp $
# $Log: space.rb,v $
# Revision 1.9  2007/06/27 12:58:20  southa
# Debian packaging
#
# Revision 1.8  2007/04/18 09:21:57  southa
# Header and level fixes
#
# Revision 1.7  2007/03/23 12:27:35  southa
# Added levels and Cistern mesh
#
# Revision 1.6  2007/03/13 18:21:36  southa
# Scanner jamming
#
# Revision 1.5  2007/03/09 11:29:12  southa
# Game end actions
#
# Revision 1.4  2007/03/08 11:00:29  southa
# Level epilogue
#
# Revision 1.3  2007/03/06 21:05:17  southa
# Level work
#
# Revision 1.2  2007/03/06 11:34:01  southa
# Space and precache fixes
#
# Revision 1.1  2007/02/08 17:55:13  southa
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

class Adanaxis_local4 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mIsBattleSet(true)
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-sanity-fault.ogg')
  end

  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
  end

  def mInitialPiecesCreate
    super
    20.times do |param|
      ['red', 'red', 'blue'].each do |colour|
        pos = MushVector.new(0, 0, 0, -200 + ((colour == 'red') ? -60 : 60)) +
          MushTools.cRandomUnitVector * (20 + rand(100));

        mPieceLibrary.mAttendantCreate(
          :colour => colour,
          :position => pos
        )
      end
    end

    4.times do |param|
      ['red', 'blue'].each do |colour|
        pos = MushVector.new(0, 0, 0, -250 + ((colour == 'red') ? -400 : 400)) + MushTools.cRandomUnitVector * (30 + rand(100));
        mPieceLibrary.mRailCreate(
          :colour => colour,
          :position => pos
        )
      end
    end

    1.times do |param|
      pos = MushVector.new(0, 0, 0, -600) + MushTools.cRandomUnitVector * (30 + rand(100));
        mPieceLibrary.mRailCreate(
          :colour => 'red',
          :position => pos,
          :is_jammer => true
        )
    end

    (0..1).each do |i|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_light_missile,
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -20-5*i)
        )
      )
    end
    mStandardCosmos(4)

  end
end
