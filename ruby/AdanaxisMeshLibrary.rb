
class AdanaxisMeshLibrary
  LOD_FACTOR = 5

  def AdanaxisMeshLibrary.sAttendantCreate
    mesh = MushMesh.new('attendant')

    number = LOD_FACTOR
    extrusion = MushExtrusion.new
    
    offset = Mush4Val.new(0,0,0,1)
    MushTools::sRotationInZWPlane(0.5 * Math::PI / number).mRotate(offset)

    angVel = MushTools::sRotationInZWPlane(Math::PI / number)

    disp = MushDisplacement.new(offset, angVel, 0.5)

	puts "disp=#{disp}"

	MushMeshLibrary.sPolygonPrismCreate(mesh, Mush4Val.new(1,1,1,1), number)

  end

  def AdanaxisMeshLibrary.sCreate
    sAttendantCreate()
  end
end
