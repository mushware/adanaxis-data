
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

    10.times do
      khazi = AdanaxisKhazi.new(
        :mesh_name => "attendant",
        :post => MushPost.new(
          :position => MushTools.cRandomUnitVector * (20 + rand(20)),
          :angular_velocity => MushTools.cRandomAngularVelocity(0.01)
          )
        )
    end

    rotMin = -0.01
    rotMax = 0.01
    
    1000.times do |i|
        pos = MushTools.cRandomUnitVector * (25 + rand(100))
      deco = AdanaxisDeco.new(
        :mesh_name => "deco#{i % 10}",
        :post => MushPost.new(
          :position => pos
            )
          )
    end
  end
end
