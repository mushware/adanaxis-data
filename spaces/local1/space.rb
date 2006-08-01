#%Header {
##############################################################################
#
# File: data-adanaxis/spaces/local1/space.rb
#
# Author: Andy Southgate 2006
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
#%Header } s0RdZ0Rim93XR+19sO4Haw
# $Id$
# $Log$

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local1 < AdanaxisSpace
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

    positions = [
      [ 0, 0, 0, -55, 0.2,0.3,0.6],
      [ 10, 20, 3, -35, 0,0.3,0.6],
      [ 5, -12, 0, -45, 0.2,0.3,0],
      [ -16, 3, -3, -45, 0.3,0.3,0.7],
      [ 0, 0, 0, -55, 0,0.3,0],
      [ 10, 20, 3, -35, 0,0.3,0.6],
      [ 5, -12, 0, -45, 0.2,0.3,0],
      [ -6, 3, -3, -45, 0.3,0.3,0.7],
      [ 8, 9, 1, -15, 0.2,0.3,0.5],
      [ 4, 12, 2, -20, 0.5,0.8,0.6],
      [ 5, -12, -2, -25, 0.2,0.7,0],
      [ -7, 3, -1, -30, 0.3,0.3,0.7],
      [ -3, 5, 0, -35, 0.3,0.1,0.6]
      ]

    positions.each do |param|
      pos = MushVector.new(param[0], param[1], param[2], param[3])
      angPos = MushTools.cRotationInXZPlane(Math::PI * 2 * param[4]);
      MushTools.cRotationInZWPlane(Math::PI * 2 * param[5]).mRotate(angPos);
      MushTools.cRotationInYZPlane(Math::PI * 2 * param[6]).mRotate(angPos);

      khazi = AdanaxisKhazi.new(
        :mesh_name => "attendant",
        :post => MushPost.new(
          :position => pos,
          :angular_position => angPos
          )
        )
    end

    rotMin = -0.01
    rotMax = 0.01
    
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
