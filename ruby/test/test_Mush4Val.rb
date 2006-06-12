

require 'test/unit'

class TestMush4Val < Test::Unit::TestCase
  def test_simple
    vec1 = Mush4Val.new(1,2,3,4);
    vec2 = Mush4Val.new(2,3,5,7);
    assert_equal(vec1+vec2, Mush4Val.new(3,5,8,11));
  end
end
