

class TopMenu
  def initialize
  end
  
  def render
    mushGL = MushGLFont.new
    mushGL.fontSize = 0.03
    mushGL.cRender(0.2, -0.4, 12345.to_s);
  end
end

puts "TopMenu loaded"
