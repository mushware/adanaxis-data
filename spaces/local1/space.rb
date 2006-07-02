
require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local1 < AdanaxisSpace
  def initialize
  end
  
  def mLoad
    mLoadStandard
  end
  
  def mInitialPiecesCreate
    super

    rotMin = -0.01
	rotMax = 0.01
	
	10.times { |i|
	  khazi = AdanaxisKhazi.new(
	    :mesh_name => 'attendant',
	    :post => MushPost.new(
	      :position => MushVector.new(20*(i+2),0,0,0),
		  :angular_velocity => MushTools.cRotationInXWPlane(i*Math::PI/1000)
        )
      )
	}
	
	angVel = MushTools.cRotationInZWPlane(Math::PI/10000)
	MushTools.cRotationInXZPlane(Math::PI/35000).mRotate(angVel)
	MushTools.cRotationInYZPlane(Math::PI/28000).mRotate(angVel)
	
    scale = 100;
    
	2.times { | i|
    
        world1 = AdanaxisDeco.new(
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
    }	
  end
  
end
