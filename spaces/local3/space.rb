#%Header {
##############################################################################
#
# File data-adanaxis/spaces/local3/space.rb
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
#%Header } XESH903Rz4omoAntOunkPg
# $Id: space.rb,v 1.16 2006/08/01 13:41:14 southa Exp $
# $Log: space.rb,v $
# Revision 1.16  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local3 < AdanaxisSpace
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
    20.times do |param|
      pos = MushVector.new(0,0,0,0) + MushTools.cRandomUnitVector * (30 + rand(100));
      angVel = MushTools.cRandomAngularVelocity(0.01)
      khazi = AdanaxisKhazi.new(
        :mesh_name => "attendant",
        :post => MushPost.new(
          :position => pos,
          :angular_velocity => angVel
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
