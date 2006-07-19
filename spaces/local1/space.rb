
require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local1 < AdanaxisSpace
  def initialize
    @preCached = 0
  end
  
  def mLoad
    mLoadStandard
    @preCached = 0
  end

  def mPreCache
    case (@preCached)
      when 0..9 :  MushGLTexture.cPreCache("flare#{@preCached}-tex")
      when 10..19 :  MushGLTexture.cPreCache("ember#{@preCached-10}-tex")
      when 20..29 :  MushGLTexture.cPreCache("star#{@preCached-20}-tex")
    end
    @preCached += 1
    30 - @preCached
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
