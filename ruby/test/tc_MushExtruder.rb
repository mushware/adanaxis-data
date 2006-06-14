
require 'test/unit'

class TestMushExtruder < Test::Unit::TestCase
  def test_simple
    disp = MushDisplacement.new
    extruder1 = MushExtruder.new(
        :sourceface => 0,
        :displacement => disp,
        :displacement_velocity => MushDisplacement.new(Mush4Val.new(1,0,0,0), MushRotation.new, 0.5),
        :scale => 1,
        :scale_velocity => 0
      )
    puts extruder1.to_xml
	assert_raise(Exception) { MushExtruder.new(:not_a_param => 0) }
  end
end
