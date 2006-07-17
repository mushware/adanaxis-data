
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

    khazi = AdanaxisKhazi.new(
      :mesh_name => "attendant",
      :post => MushPost.new(
        :position => MushVector.new(20,0,0,0)
        )
      )

    rotMin = -0.01
	rotMax = 0.01
	
	1000.times do |i|
      pos = MushTools.cRandomUnitVector * (30 + rand(100))
	  deco = AdanaxisDeco.new(
	    :mesh_name => "deco#{i % 10}",
	    :post => MushPost.new(
	      :position => pos
          )
        )
	end
  end
end
