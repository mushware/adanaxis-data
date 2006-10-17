#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisMeshLibrary.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 74bLa8v94NQFxupv0Pj/cA
# $Id: AdanaxisMeshLibrary.rb,v 1.18 2006/10/05 15:39:16 southa Exp $
# $Log: AdanaxisMeshLibrary.rb,v $
# Revision 1.18  2006/10/05 15:39:16  southa
# Explosion handling
#
# Revision 1.17  2006/08/20 14:19:20  southa
# Seek operation
#
# Revision 1.16  2006/08/01 17:21:18  southa
# River demo
#
# Revision 1.15  2006/08/01 13:41:12  southa
# Pre-release updates
#

class AdanaxisMeshLibrary
  LOD_FACTOR = 5

  #
  # Attendant mesh
  #
  
  def self.cAttendantCreate
    mesh = MushMesh.new('attendant')

    base1 = MushBasePrism.new(:order => 5)
	
	baseDisplacement1 = MushDisplacement.new(
		:offset => MushVector.new(0,0,0,0),
        :scale => MushVector.new(Math.sqrt(2),Math.sqrt(2),1,1)
	  )
	
    extruder1 = MushExtruder.new(
        :sourceface => 2,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,-1,0),
            :rotation => MushTools.cRotationInZWPlane(Math::PI/8),
            :scale => 0.8),
		:num_iterations => 8
      )
	  
    extruder2 = MushExtruder.new(
        :sourceface => 3,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,1,0),
            :rotation => MushTools.cRotationInZWPlane(-Math::PI/8),
            :scale => 0.8),
		:num_iterations => 8
      )
	  
    extruder3 = MushExtruder.new(
        :sourceface => 0,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,0,-1),
            :scale => 0.6),
		:num_iterations => 10
      )

    extruder4 = MushExtruder.new(
        :sourceface => 10,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,-1,0),
            :rotation => MushTools.cRotationInZWPlane(Math::PI/8),
            :scale => 0.4),
		:num_iterations => 2
      )

    extruder5 = MushExtruder.new(
        :sourceface => 2+4*8,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,-1,0),
            :rotation => MushTools.cRotationInZWPlane(-Math::PI/8),
            :scale => 0.4),
		:num_iterations => 2
      )

    extruder6 = MushExtruder.new(
        :sourceface => 2+9*8,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,-1,0),
            :rotation => MushTools.cRotationInZWPlane(-Math::PI/8),
            :scale => 0.4),
		:num_iterations => 2
      )

    extruder7 = MushExtruder.new(
        :sourceface => 2+12*8,
        :displacement => MushDisplacement.new(
            :offset => MushVector.new(0,0,-1,0),
            :rotation => MushTools.cRotationInZWPlane(+Math::PI/8),
            :scale => 0.4),
		:num_iterations => 2
      )


	mesh.mBaseAdd(base1)
	mesh.mBaseDisplacementAdd(baseDisplacement1)
    mesh.mExtruderAdd(extruder1)
    mesh.mExtruderAdd(extruder2)
    mesh.mExtruderAdd(extruder3)
    #mesh.mExtruderAdd(extruder4)
    #mesh.mExtruderAdd(extruder5)
    #mesh.mExtruderAdd(extruder6)
    #mesh.mExtruderAdd(extruder7)
	mesh.mMaterialAdd('attendant-mat')

    mesh.mMake
  end

  def self.cPlayerCreate
    mesh = MushMesh.new('player')

    base1 = MushBasePrism.new(:order => 4)
	
	  baseDisplacement1 = MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,0),
      :scale => MushVector.new(Math.sqrt(2),Math.sqrt(2),1,1)
	  )
	
    extruder1 = MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
      :offset => MushVector.new(0,0,-1,0),
      :rotation => MushTools.cRotationInZWPlane(Math::PI/8),
      :scale => 0.8),
		  :num_iterations => 5
    )
	  
    extruder2 = MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
      :offset => MushVector.new(0,0,1,0),
      :rotation => MushTools.cRotationInZWPlane(-Math::PI/8),
      :scale => 0.8),
      :num_iterations => 5
    )
	  
    extruder3 = MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
      :offset => MushVector.new(0,0,0,-1),
      :scale => 0.6),
      :num_iterations => 3
    )

    mesh.mBaseAdd(base1)
    mesh.mBaseDisplacementAdd(baseDisplacement1)
    mesh.mExtruderAdd(extruder1)
    mesh.mExtruderAdd(extruder2)
    mesh.mExtruderAdd(extruder3)
    mesh.mMaterialAdd('player-mat')

    mesh.mMake
  end


  #
  # Axes mesh
  #
  
  def AdanaxisMeshLibrary.cAxesCreate
    mesh = MushMesh.new('axes')

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
	mesh.mMaterialAdd('axes-mat')

    mesh.mMake
  end
  
  
  #
  # Cube meshes
  #
  
  def AdanaxisMeshLibrary.cCubesCreate
  	baseDisplacement1 = MushDisplacement.new(
        :scale => MushVector.new(0.9*Math.sqrt(2),0.9*Math.sqrt(2),0.9,0.9)
	  )

    begin
      mesh = MushMesh.new('ground1')
      base = MushBasePrism.new(:order => 4)
      mesh.mBaseAdd(base)
      mesh.mBaseDisplacementAdd(baseDisplacement1)
      mesh.mMaterialAdd('ground1-mat')
      mesh.mMake
    end
    begin
      mesh = MushMesh.new('river1')
      base = MushBasePrism.new(:order => 4)
      mesh.mBaseAdd(base)
      mesh.mBaseDisplacementAdd(baseDisplacement1)
      mesh.mMaterialAdd('river1-mat')
      mesh.mMake
    end
    begin
      mesh = MushMesh.new('block1')
      base = MushBasePrism.new(:order => 4)
      mesh.mBaseAdd(base)
      mesh.mBaseDisplacementAdd(baseDisplacement1)
      mesh.mMaterialAdd('block1-mat')
      mesh.mMake
    end
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

  #
  # Single facet meshes
  #
  
  def AdanaxisMeshLibrary.cEmbersCreate
    10.times do |i|
      mesh =  MushMesh.new("ember#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("ember#{i}-mat")
      mesh.mMake
    end
  end  

  def AdanaxisMeshLibrary.cFlaresCreate
    10.times do |i|
      mesh =  MushMesh.new("flare#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("flare#{i}-mat")
      mesh.mMake
    end
  end  

  def AdanaxisMeshLibrary.cStarsCreate
    10.times do |i|
      mesh =  MushMesh.new("star#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("star#{i}-mat")
      mesh.mMake
    end
  end
    
  def AdanaxisMeshLibrary.cExploCreate
    10.times do |i|
      mesh =  MushMesh.new("explo#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("explo#{i}-mat")
      mesh.mMake
    end
  end  

  def AdanaxisMeshLibrary.cCreate
    cAttendantCreate
    cCubesCreate
    cProjectileCreate
    cWorldCreate
    cStarsCreate
    cEmbersCreate
    cFlaresCreate
    cExploCreate
    cPlayerCreate
  end
end
