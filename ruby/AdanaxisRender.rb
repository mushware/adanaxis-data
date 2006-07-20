require 'Mushware.rb'

class AdanaxisRender < MushObject
  def intialize
  end
 
  def mCreate
    @menuFont = MushGLFont.new(:name => 'library-font1');
    @menuStr = "Menu from ruby";
  end
    
  def mRenderMenu
    @menuFont.mRender(@menuStr)
  end
  
  def mRender
    mRenderMenu
  end

  def mPreCacheRender(percentage)
    @menuFont.colour = MushVector.new(1,1,1,0.3)
    @menuFont.mRenderAtSize("Loading... #{percentage}%", -0.4, -0.25, 0.02);
  end

end
