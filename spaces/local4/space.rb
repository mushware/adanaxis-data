#%Header {
##############################################################################
#
# File data-adanaxis/spaces/local4/space.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 9btZJX1RwZdHfO/OWZksXQ
# $Id: space.rb,v 1.1 2007/02/08 17:55:13 southa Exp $
# $Log: space.rb,v $
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
  end
  
  def mLoad(game)
    mLoadStandard(game)
    MushGame.cSoundStreamDefine('game1', MushConfig.cGlobalWavesPath+'/mushware-respiration.ogg')
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red', 'blue'))
    mPrecacheListAdd(mPieceLibrary.mRailTex('red', 'blue'))
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
      ['red', 'blue'].each do |colour|
        pos = MushVector.new((colour == 'red') ? -200 : 200, 0, 0, -400) + MushTools.cRandomUnitVector * (30 + rand(100));
        mPieceLibrary.mRailCreate(
          :colour => colour,
          :position => pos
        )
      end    end

    mStandardCosmos(4)
    
  end
end
