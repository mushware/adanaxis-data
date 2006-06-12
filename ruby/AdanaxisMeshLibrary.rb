
class AdanaxisMeshLibrary
  def AdanaxisMeshLibrary.sCreate
    mesh1 = MushMesh.new('attendant')
	MushMeshLibrary.sPolygonPrismCreate(mesh1, Mush4Val.new(1,1,1,1), 7)
  end
end
