

require 'test/unit'

class TestMushVector < Test::Unit::TestCase
  def test_simple
    vec1 = MushVector.new(1,2,3,4);
    vec2 = MushVector.new(2,3,5,7);
    assert_equal(vec1+vec2, MushVector.new(3,5,8,11));
  end
end
