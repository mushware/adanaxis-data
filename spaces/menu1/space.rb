
require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_menu1 < AdanaxisSpace
  def initialize
    @preCached = 0
  end
  
  def mLoad
    mLoadStandard
    @preCached = 0
  end

  def mPreCache
    num = @preCached
    @preCached += 1
    case (num)
      when 27     : MushGLTexture.cPreCache("attendant-tex")
    end
    
    num*2
  end
  
  def mInitialPiecesCreate
    super

    angVel = MushTools.cRotationInXYPlane(Math::PI / 200);
    MushTools.cRotationInZWPlane(Math::PI / 473).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 670).mRotate(angVel);
    
    1.times do
      khazi = AdanaxisKhazi.new(
        :mesh_name => "attendant",
        :post => MushPost.new(
          :position => MushVector.new(0,0,0,-20),
          :angular_velocity => angVel
          )
        )
    end

    def mIsMenuBackdrop
      true
    end

  end
end
