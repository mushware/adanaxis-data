
require 'test/unit'

class TestMushExtruder < Test::Unit::TestCase
  def test_simple
    extruder1 = MushExtruder.new(
        :sourceface => 0,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(1,0,0,0),
            :rotation => MushTools.cRotationInZWPlane(Math::PI/2),
            :scale => 1.0),
        :displacement_velocity => MushDisplacement.new(MushVector.new(1,0,0,0), MushRotation.new, 0.5),
		:num_iterations => 3,
		:to_point => true
      )
	assert_raise(Exception) { MushExtruder.new(:not_a_param => 0) }
  end
end
