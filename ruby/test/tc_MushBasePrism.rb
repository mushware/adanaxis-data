
class TestMushBasePrism < Test::Unit::TestCase
  def test_simple
    baseprism1 = MushBasePrism.new(5)
	baseprism1 = MushBasePrism.new(:order => 5)
	
	assert_raise(Exception) { MushBasePrism.new }
	assert_raise(Exception) { MushBasePrism.new(:not_a_param => 0) }

  end
end
