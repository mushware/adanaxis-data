#%Header {
##############################################################################
#
# File data-adanaxis/spaces/local2/space.rb
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
#%Header } XulYrmMGLmszzHG2i2jMtA
# $Id: space.rb,v 1.7 2006/08/02 15:41:46 southa Exp $
# $Log: space.rb,v $
# Revision 1.7  2006/08/02 15:41:46  southa
# Prerelease work
#
# Revision 1.6  2006/08/01 23:21:49  southa
# Rendering demo content
#
# Revision 1.5  2006/08/01 17:21:19  southa
# River demo
#
# Revision 1.4  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local2 < AdanaxisSpace
  def initialize
    @preCached = 0
  end
  
  def mLoad(game)
    mLoadStandard(game)
    MushGame.cSoundStreamDefine('game1', MushConfig.cGlobalWavesPath+'/mushware-respiration.ogg')
  end
  
  def mPreCache
    num = @preCached
    # Must still increment @preCached if cPreCache throws
    @preCached += 1
    case (num)
      when 0..9   : MushGLTexture.cPreCache("flare#{num}-tex")
      when 10..19 : MushGLTexture.cPreCache("ember#{num-10}-tex")
      when 20..29 : MushGLTexture.cPreCache("star#{num-20}-tex")
      when 30     : MushGLTexture.cPreCache("attendant-tex")
      when 31     : MushGLTexture.cPreCache("projectile-tex")
    end
    
    3 * num
  end
  
  def mInitialPiecesCreate
    super

    12.times do |i|
      
      x, y, z, w = 0, 0, 0, 0
      span = 10
      
      case i
        when 0, 6: x = -span
        when 1, 7: x =  span
        when 2, 8: y = -span
        when 3, 9: y =  span
        when 4, 10: z = -span
        when 5, 11: z =  span
      end
      
      if i < 6
        w = 0
        vw = -0.3
      else
        w = -1000
        vw = 0.1
      end
      
      if (i % 2) == 0
        rotate = 1
      else
        rotate = -1
      end
      
      x+=0.4
      y+=0.7
      
      khazi = AdanaxisPieceKhazi.cCreate(
        :mesh_name => 'attendant',
        :post => MushPost.new(
          :position => MushVector.new(x, y, z, w),
          :velocity => MushVector.new(0, 0, 0, vw),
          :angular_position => MushTools.cRotationInYWPlane(-Math::PI/2).mRotate(MushTools.cRotationInYZPlane(-Math::PI/2).mRotate(MushTools.cRotationInZWPlane(-Math::PI/2))),
          :angular_velocity => MushTools.cRotationInXYPlane(rotate * Math::PI/1000)
          )
        )
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
