#%Header {
##############################################################################
#
# File data-adanaxis/spaces/gameend1/space.rb
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
#%Header } cZPMFochXsLeJCx7Cky+NQ
# $Id: space.rb,v 1.1 2007/06/12 11:09:36 southa Exp $
# $Log: space.rb,v $
# Revision 1.1  2007/06/12 11:09:36  southa
# Level 28
#
# Revision 1.1  2007/06/08 13:17:14  southa
# Level 25
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_gameend1 < AdanaxisSpace
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
