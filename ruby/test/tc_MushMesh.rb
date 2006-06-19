
require 'test/unit'

class TestMushMesh < Test::Unit::TestCase
  def test_simple
    mesh1 = MushMesh.new('testmesh')
	extruder1 = MushExtruder.new
    mesh1.mExtruderAdd(extruder1)
	mesh1.mMaterialAdd('material1')
  end
end
