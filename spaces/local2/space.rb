#%Header {
##############################################################################
#
# File: data-adanaxis/spaces/local2/space.rb
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
#%Header } wS3f42qGmlOzQy1W6Ke/rg
# $Id$
# $Log$

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local2 < AdanaxisSpace
  def initialize
  end
  
  def mLoad(game)
    mLoadStandard(game)
  end
  
  def mInitialPiecesCreate
    super

    rotMin = -0.01
    rotMax = 0.01
    
    10.times { |i|
      khazi = AdanaxisKhazi.new(
        :mesh_name => 'attendant',
        :post => MushPost.new(
          :position => MushVector.new(20*(i),0,0,0),
        :angular_velocity => MushTools.cRotationInXWPlane(i*Math::PI/1000)
          )
        )
    }
    
    angVel = MushTools.cRotationInZWPlane(Math::PI/10000)
    MushTools.cRotationInXZPlane(Math::PI/35000).mRotate(angVel)
    MushTools.cRotationInYZPlane(Math::PI/28000).mRotate(angVel)
    
    scale = 100;
      
    16.times do | i|
      
      world1 = AdanaxisWorld.new(
        :mesh_name => 'world1',
        :post => MushPost.new(
          :position => MushVector.new(((i & 1) == 0)?scale:-scale,
                                      ((i & 2) == 0)?scale:-scale,
                                      ((i & 4) == 0)?scale:-scale,
                                      ((i & 8) == 0)?scale:-scale),
  #            , :angular_position => MushTools.cRotationInXZPlane(Math::PI/4)
          :angular_velocity => angVel
        )
      )
    end
  end  
end
