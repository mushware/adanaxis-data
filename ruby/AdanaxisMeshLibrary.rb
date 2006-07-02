
class AdanaxisMeshLibrary
  LOD_FACTOR = 5

  #
  # Attendant mesh
  #
  
  def AdanaxisMeshLibrary.cAttendantCreate
    mesh = MushMesh.new('attendant')

    base1 = MushBasePrism.new(:order => 4)
	
	baseDisplacement1 = MushDisplacement.new(
		:offset => MushVector.new(2,2,2,2),
        :scale => MushVector.new(Math.sqrt(2),Math.sqrt(2),1,1)
	  )
	
    extruder1 = MushExtruder.new(
        :sourceface => 0,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,0,-1),
            :rotation => MushTools.cRotationInZWPlane(0*Math::PI/20),
            :scale => 1.0),
		:num_iterations => 4
      )
	  
    extruder2 = MushExtruder.new(
        :sourceface => 2,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,-1,0),
            :rotation => MushTools.cRotationInZWPlane(0*Math::PI/20),
            :scale => 1.0),
		:num_iterations => 4
      )
	  
    extruder3 = MushExtruder.new(
        :sourceface => 7,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,-1,0,0),
            :rotation => MushTools.cRotationInZWPlane(0*Math::PI/20),
            :scale => 1.0),
		:num_iterations => 4
      )

    extruder4 = MushExtruder.new(
        :sourceface => 6,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(-1,0,0,0),
            :rotation => MushTools.cRotationInZWPlane(0*Math::PI/20),
            :scale => 1.0),
		:num_iterations => 4
      )

	mesh.mBaseAdd(base1)
	mesh.mBaseDisplacementAdd(baseDisplacement1)
    mesh.mExtruderAdd(extruder1)
    mesh.mExtruderAdd(extruder2)
    mesh.mExtruderAdd(extruder3)
    mesh.mExtruderAdd(extruder4)
	mesh.mMaterialAdd('attendant-mat')

    mesh.mMake
  end
  
  #
  # Projectile mesh
  #
  
  def AdanaxisMeshLibrary.cProjectileCreate
	mesh =  MushMesh.new('projectile')

	base1 = MushBasePrism.new(:order => 5)
	
	baseDisplacement1 = MushDisplacement.new(
		:offset => MushVector.new(0,0,0,0.5),
        :scale => MushVector.new(0.25,0.25,0.20,1)
	  )
	
    extruder1 = MushExtruder.new(
        :sourceface => 0,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,0,-1),
            :scale => 0.5),
		:num_iterations => 1,
		:to_point => true
      )

	mesh.mBaseAdd(base1)
	mesh.mBaseDisplacementAdd(baseDisplacement1)
    mesh.mExtruderAdd(extruder1)
	mesh.mMaterialAdd('projectile-mat')
	
	mesh.mMake
  end

  #
  # World mesh
  #
  
  def AdanaxisMeshLibrary.cWorldCreate
	mesh =  MushMesh.new('world1')

	base1 = MushBasePrism.new(:order => 4)
	
	baseDisplacement1 = MushDisplacement.new(
		:offset => MushVector.new(0,0,0,0),
        :scale => MushVector.new(142,142,100,100)
	  )
	
    extruder1 = MushExtruder.new(
        :sourceface => 0,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,0,-70),
            :scale => 0.5),
		:num_iterations => 1
      )

    extruder2 = MushExtruder.new(
        :sourceface => 1,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,0,70),
            :scale => 0.5),
		:num_iterations => 1
      )

	mesh.mBaseAdd(base1)
	mesh.mBaseDisplacementAdd(baseDisplacement1)
    mesh.mExtruderAdd(extruder1)
    mesh.mExtruderAdd(extruder2)
	mesh.mMaterialAdd('world1-mat')
	
	mesh.mMake
  end

  def AdanaxisMeshLibrary.cCreate
    cAttendantCreate()
    cProjectileCreate()
    cWorldCreate()
  end
end
