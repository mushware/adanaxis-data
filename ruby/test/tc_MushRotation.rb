
require 'test/unit'
require 'MushRotation.rb'

class TestMushRotation < Test::Unit::TestCase
  def test_simple
    vec1 = MushVector.new(1,0,0,0)
    vec1initial = vec1.clone
    rot1 = MushRotation.new
    assert_equal(vec1, vec1initial)
  end
end
