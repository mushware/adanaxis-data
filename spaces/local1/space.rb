
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
	
	(0..9).each { |i|
	  khazi = AdanaxisKhazi.new(
	    :mesh_name => 'attendant',
	    :post => MushPost.new(
	      :position => MushVector.new(20*(i+2),0,0,0),
		  :angular_velocity => MushTools.cRotationInZWPlane(i*Math::PI/1000)
        )
      )
	}
	
	world1 = AdanaxisDeco.new(
      :mesh_name => 'world1',
	  :post => MushPost.new(
	  :position => MushVector.new(0,0,0,0),
	  :angular_position => MushTools.cRotationInXZPlane(Math::PI/4)	  )
	)
	world2 = AdanaxisDeco.new(
      :mesh_name => 'world1',
	  :post => MushPost.new(
	  :position => MushVector.new(0,0,0,0),
	  :angular_position => MushTools.cRotationInZWPlane(Math::PI/4)	  )
	)
  end
  
end
