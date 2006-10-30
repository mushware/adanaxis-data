#%Header {
##############################################################################
#
# File data-adanaxis/spaces/menu1/space.rb
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
#%Header } +qJXLcrDec2QZ7WFKpERPQ
# $Id: space.rb,v 1.14 2006/10/30 17:03:50 southa Exp $
# $Log: space.rb,v $
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

  def mPreCache
    num = @preCached
    @preCached += 1
    case (num)
      when 27     : MushGLTexture.cPreCache("attendant-tex")
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
