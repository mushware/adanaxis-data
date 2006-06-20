
require 'test/unit'
require 'MushVector.rb'

class TestMushMeshLibrary < Test::Unit::TestCase
  def test_simple
    mesh1 = MushMesh.new('testmesh')
	MushMeshLibrary.cPolygonPrismCreate(mesh1, MushVector.new(1,1,1,1), 5)
  end
end
