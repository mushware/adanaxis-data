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
end
