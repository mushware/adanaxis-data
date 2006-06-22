
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
	
	(1..0).each { |i|
	  khazi = AdanaxisKhazi.new(
	    :mesh_name => 'attendant',
	    :post => MushPost.new(
	      :position => MushVector.new(20*(i+2),0,0,0),
		  :angular_velocity => MushTools.cRotationInXWPlane(i*Math::PI/1000)
        )
      )
	}
	
	angVel = MushTools.cRotationInZWPlane(Math::PI/1000)
	MushTools.cRotationInXZPlane(Math::PI/350).mRotate(angVel)
	MushTools.cRotationInYZPlane(Math::PI/280).mRotate(angVel)
	
	
	world1 = AdanaxisKhazi.new(
      :mesh_name => 'world1',
	  :post => MushPost.new(
	    :position => MushVector.new(0,0,0,0),
	    :angular_position => MushTools.cRotationInXZPlane(Math::PI/4),
	    :angular_velocity => angVel
	  )
	)
	
  end
  
end
