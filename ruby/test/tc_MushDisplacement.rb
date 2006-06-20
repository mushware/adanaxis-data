
require 'test/unit'

class TestMushDisplacement < Test::Unit::TestCase
  def test_simple
    disp1 = MushDisplacement.new()
	disp2 = MushDisplacement.new(
            :offset => MushVector.new(1,0,0,0),
            :rotation => MushTools.cRotationInZWPlane(Math::PI/2),
            :scale => 0.3)

	disp3 = MushDisplacement.new(
            :scale => MushVector.new(0.5,1,1,1))

	assert_raise(Exception) { MushDisplacement.new(:not_a_param => 0) }

  end
end
