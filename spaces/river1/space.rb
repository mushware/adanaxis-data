#%Header {
##############################################################################
#
# File data-adanaxis/spaces/river1/space.rb
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
#%Header } dor7oAM3xOfZ2ElF/iVHGg
# $Id: space.rb,v 1.4 2006/10/06 14:48:18 southa Exp $
# $Log: space.rb,v $
# Revision 1.4  2006/10/06 14:48:18  southa
# Material animation
#
# Revision 1.3  2006/10/03 14:06:50  southa
# Khazi and projectile creation
#
# Revision 1.2  2006/08/02 15:41:46  southa
# Prerelease work
#
# Revision 1.1  2006/08/01 17:21:20  southa
# River demo
#
# Revision 1.16  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_river1 < AdanaxisSpace
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
    # Must still increment @preCached if cPrecache throws
    @preCached += 1
    case (num)
      when 9   : MushGLTexture.cPrecache("river1-tex")
      when 19 : MushGLTexture.cPrecache("ground1-tex")
    end
    
    3 * num
  end
  
  def mInitialPiecesCreate
    super

    # Create the river and ground
    5.times do |x|
      y=-3
      5.times do |z|
        5.times do |w|
          if (w == 2 && z == 2)
            meshName = 'river1'
          else
            meshName = 'ground1'
          end
          AdanaxisPieceKhazi.cCreate(
            :mesh_name => meshName,
            :post => MushPost.new(
              :position => MushVector.new(x-2, y-2, z-2, w-30)
            )
          )
        end
      end
    end
      
    1000.times do |i|
      pos = MushTools.cRandomUnitVector * (30 + rand(100))
      world = AdanaxisWorld.new(
        :mesh_name => "star#{i % 10}",
        :post => MushPost.new(
          :position => pos
          )
        )
    end
    
  end
end
