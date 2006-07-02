
class TestMushGLFont < Test::Unit::TestCase
  def test_simple
	font1 = MushGLFont.new(
      :name => 'font1',
      :texture_name => 'font1-tex',
      :divide => [8,12],
      :extent => [337, 768]
    )
    
    puts font1.to_xml
    
	assert_raise(Exception) { MushGLFont.new }
	assert_raise(Exception) { MushGLFont.new(5) }
	assert_raise(Exception) { MushGLFont.new(:not_a_param => 0) }
  end
end
