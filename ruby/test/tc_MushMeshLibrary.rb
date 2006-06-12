
require 'test/unit'
require 'Mush4Val.rb'

class TestMushMeshLibrary < Test::Unit::TestCase
  def test_simple
    mesh1 = MushMesh.new('testmesh')
	MushMeshLibrary.sPolygonPrismCreate(mesh1, Mush4Val.new(1,1,1,1), 5)
  end
end
