
class AdanaxisMeshLibrary
  LOD_FACTOR = 5

  def AdanaxisMeshLibrary.sAttendantCreate
    mesh = MushMesh.new('attendant')

    number = LOD_FACTOR

    disp = 
    extruder = MushExtruder.new

    extruder1 = MushExtruder.new(
        :sourceface => 0,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(1,0,0,0),
            :rotation => MushTools.sRotationInZWPlane(Math::PI/2),
            :scale => 1.0),
        :displacement_velocity => MushDisplacement.new(MushVector.new(1,0,0,0), MushRotation.new, 0.5)
      )

    mesh.mExtruderAdd(extruder)
    mesh.mMake
  end

  def AdanaxisMeshLibrary.sCreate
    sAttendantCreate()
  end
end
