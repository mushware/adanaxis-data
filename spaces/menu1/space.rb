#%Header {
##############################################################################
#
# File adanaxis-data/spaces/menu1/space.rb
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
#%Header } hI7asLR78VHOw5SoV1WuOg
# $Id: space.rb,v 1.30 2007/06/27 12:58:20 southa Exp $
# $Log: space.rb,v $
# Revision 1.30  2007/06/27 12:58:20  southa
# Debian packaging
#
# Revision 1.29  2007/06/15 12:45:49  southa
# Prerelease work
#
# Revision 1.28  2007/06/08 16:23:04  southa
# Level 26
#
# Revision 1.27  2007/06/06 12:24:14  southa
# Level 22
#
# Revision 1.26  2007/04/26 13:12:40  southa
# Limescale and level 9
#
# Revision 1.25  2007/04/19 12:57:57  southa
# Prerelease work
#
# Revision 1.24  2007/04/18 12:44:36  southa
# Cache purge fix and pre-release tweaks
#
# Revision 1.23  2007/04/18 09:21:57  southa
# Header and level fixes
#
# Revision 1.22  2007/03/28 14:45:47  southa
# Level and AI standoff
#
# Revision 1.21  2007/03/24 18:07:23  southa
# Level 3 work
#
# Revision 1.20  2007/03/23 12:27:35  southa
# Added levels and Cistern mesh
#
# Revision 1.19  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.18  2007/02/08 17:55:13  southa
# Common routines in space generation
#
# Revision 1.17  2006/12/16 10:57:22  southa
# Encrypted files
#
# Revision 1.16  2006/11/07 11:08:54  southa
# Texture loading from mushfiles
#
# Revision 1.15  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.14  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.13  2006/10/19 15:41:35  southa
# Item handling
#
# Revision 1.12  2006/10/18 13:22:08  southa
# World rendering
#
# Revision 1.11  2006/10/14 16:59:43  southa
# Ruby Deco objects
#
# Revision 1.10  2006/10/09 16:00:15  southa
# Intern generation
#
# Revision 1.9  2006/10/06 14:48:18  southa
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
# Revision 1.5  2006/08/01 17:21:20  southa
# River demo
#
# Revision 1.4  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_menu1 < AdanaxisSpace
  def initialize(inParams = {})
    super
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('theme1', 'mushware-adanaxistheme.ogg')
  end

  def mPrecacheListBuild
    # Don't call super - needn't cache entire cosmos, explosions etc.
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
  end

  def mInitialPiecesCreate
    super

    angVel = MushTools.cRotationInXYPlane(Math::PI / 700);
    MushTools.cRotationInZWPlane(Math::PI / 873).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 970).mRotate(angVel);

    mPieceLibrary.mAttendantCreate(
      :colour => 'red',
      :post => MushPost.new(
        :position => MushVector.new(0,0,0,-18),
        :angular_position => MushTools.cRandomOrientation,
        :angular_velocity => angVel
        ),
      :patrol_points => [MushVector.new(0,0,0,0)]
    )

    mStandardCosmos(1)
  end

  def mIsMenuBackdrop
    true
  end
end
