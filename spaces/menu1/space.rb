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
# $Id: space.rb,v 1.5 2006/08/01 17:21:20 southa Exp $
# $Log: space.rb,v $
# Revision 1.5  2006/08/01 17:21:20  southa
# River demo
#
# Revision 1.4  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_menu1 < AdanaxisSpace
  def initialize
    @preCached = 0
  end
  
  def mLoad(game)
    mLoadStandard(game)
    MushGame.cSoundStreamDefine('game1', MushConfig.cGlobalWavesPath+'/mushware-respiration.ogg')
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
      khazi = AdanaxisKhazi.new(
        :mesh_name => "attendant",
        :post => MushPost.new(
          :position => MushVector.new(0,0,0,-20),
          :angular_velocity => angVel
          )
        )
    end

    def mIsMenuBackdrop
      true
    end

  end
end
