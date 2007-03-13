#%Header {
##############################################################################
#
# File data-adanaxis/spaces/menu1/space.rb
#
# Copyright Andy Southgate 2006-2007
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
#%Header } r4tQ/n6wg5jStMnjHe2PIg
# $Id: space.rb,v 1.18 2007/02/08 17:55:13 southa Exp $
# $Log: space.rb,v $
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
    @preCached = 0
  end
  
  def mLoad(game)
    mLoadStandard(game)
    MushGame.cSoundStreamDefine('theme1', MushConfig.cGlobalWavesPath+'/mushware-adanaxistheme.ogg')
    @preCached = 0
  end

  def mPrecache
    num = @preCached
    @preCached += 1
    case (num)
      when 27     : MushGLTexture.cPrecache("attendant-tex")
    end
    
    num*2
  end
  
  def mInitialPiecesCreate
    super

    angVel = MushTools.cRotationInXYPlane(Math::PI / 200);
    MushTools.cRotationInZWPlane(Math::PI / 473).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 670).mRotate(angVel);
    
    1.times do
      khazi = AdanaxisPieceKhazi.cCreate(
        :mesh_name => "attendant",
        :hit_points => 10.0,
        :post => MushPost.new(
          :position => MushVector.new(0,0,0,-20),
          :angular_velocity => angVel
          ),
        :remnant => :health1
      )
    end
    
    begin
      1000.times do |i|
        pos = MushTools.cRandomUnitVector * (10 + rand(40))
        world = AdanaxisWorld.new(
          :mesh_name => mMeshLibrary.mRandomCosmosName,
          :post => MushPost.new(
            :position => pos
            )
          )
      end
    rescue Exception => e
      MushLog.cWarning "Cosmos construction failed: #{e} at #{e.backtrace[0]}"
    end
  end

  def mIsMenuBackdrop
    true
  end
end
