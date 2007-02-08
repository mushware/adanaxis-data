#%Header {
##############################################################################
#
# File data-adanaxis/spaces/local4/space.rb
#
# Author Andy Southgate 2006
#
# This file contains original work by Andy Southgate.  The author and his
# employer (Mushware Limited) irrevocably waive all of their copyright rights
# vested in this particular version of this file to the furthest extent
# permitted.  The author and Mushware Limited also irrevocably waive any and
# all of their intellectual property rights arising from said file and its
# creation that would otherwise restrict the rights of any party to use and/or
# distribute the use of, the techniques and methods used herein.  A written
# waiver can be obtained via http://www.mushware.com/.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } HacRfZ2xB2ikp+zBw7iYuw
# $Id: space.rb,v 1.17 2006/12/18 15:39:35 southa Exp $
# $Log: space.rb,v $
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
