#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisMeshLibrary.rb
#
# Copyright Andy Southgate 2006-2007
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
#%Header } 8Ft/KCtkgdEE2CxrOoI0Rg
# $Id: AdanaxisMeshLibrary.rb,v 1.30 2007/02/08 17:55:12 southa Exp $
# $Log: AdanaxisMeshLibrary.rb,v $
# Revision 1.30  2007/02/08 17:55:12  southa
# Common routines in space generation
#
# Revision 1.29  2006/12/18 15:39:35  southa
# Palette changes
#
# Revision 1.28  2006/11/17 15:47:42  southa
# Ammo remnants
#
# Revision 1.27  2006/11/17 13:22:06  southa
# Box textures
#
# Revision 1.26  2006/11/15 18:25:54  southa
# Khazi rails
#
# Revision 1.25  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.24  2006/11/14 14:02:15  southa
# Ball projectiles
#
# Revision 1.23  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.22  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.21  2006/10/19 15:41:34  southa
# Item handling
#
# Revision 1.20  2006/10/18 13:22:08  southa
# World rendering
#
# Revision 1.19  2006/10/17 15:28:00  southa
# Player collisions
#
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

  def initialize(inParams = {})
    @m_textureLibrary = inParams[:texture_library] || raise("No texture library supplied to mesh library")
  end
  
  #
  # Khazi Rail
  #
  # Big, heavy khazi equipped with a rail gun
  #
  def mKhaziRailCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 4))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,2),
      :scale => MushVector.new(2*Math.sqrt(2),2*Math.sqrt(2),2,2)
	  ))
	
    arms = 2.0
  
    # Nose 1
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1),
        :scale => 1.1),
  		:num_iterations => 2
    ))
    
    # Nose 2
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 8+7,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-2),
        :scale => 0.7),
  		:num_iterations => 3
    ))
  
    # Boom -x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 6,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(-arms,0,0,0),
        :rotation => MushTools.cRotationInXWPlane(Math::PI/6),
        :scale => 0.75
      ),
		  :num_iterations => 5
    ))
	  
    # Boom +x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 4,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(arms,0,0,0),
        :rotation => MushTools.cRotationInXWPlane(-Math::PI/6),
        :scale => 0.75
      ),
      :num_iterations => 5
    ))
	  
    # Boom -y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,-arms,0,0),
        :rotation => MushTools.cRotationInYWPlane(Math::PI/6),
        :scale => 0.75
      ),
		  :num_iterations => 5
    ))
	  
    # Boom +y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 5,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,arms,0,0),
        :rotation => MushTools.cRotationInYWPlane(-Math::PI/6),
        :scale => 0.75
      ),
      :num_iterations => 5
    ))
	  
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-arms,0),
        :rotation => MushTools.cRotationInZWPlane(Math::PI/6),
        :scale => 0.75
      ),
		  :num_iterations => 5
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,arms,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/6),
        :scale => 0.75
      ),
      :num_iterations => 5
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.0),
        :scale => 0.5),
  		:num_iterations => 3
    ))

    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end

  #
  # Attendant mesh
  #
  # Cannon fodder, lots of them, quick to render
  def mAttendantCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 5))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,1),
      :scale => MushVector.new(Math.sqrt(2),Math.sqrt(2),1,1)
	  ))
	
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-0.5,0),
        :rotation => MushTools.cRotationInZWPlane(Math::PI/6),
        :scale => 0.75
      ),
		  :num_iterations => 4
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0.5,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/6),
        :scale => 0.75
      ),
      :num_iterations => 4
    ))
	  
    # Nose
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1),
        :scale => 0.6),
  		:num_iterations => 3
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.0),
        :scale => 0.75),
  		:num_iterations => 1
    ))

    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end


  #
  # Attendant mesh
  #
  
  def mKleenorCreate
    mesh = MushMesh.new('kleenor')

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

  def mPlayerCreate
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
  
  def mAxesCreate
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
  
  def mCubesCreate
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
  
  def mProjectileCreate
    mesh =  MushMesh.new('projectile1')

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
    mesh.mMaterialAdd('projectile1-mat')
    
    mesh.mMake
    
    mesh =  MushMesh.new('projectile2')

    base1 = MushBasePrism.new(:order => 9)
    
    baseDisplacement1 = MushDisplacement.new(
      :offset => MushVector.new(0,0,0,2),
          :scale => MushVector.new(1,1,0.8,4)
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
    mesh.mMaterialAdd('projectile2-mat')
    
    mesh.mMake

  end

  #
  # World mesh
  #
  
  def mWorldCreate
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
  
  def mEmbersCreate
    10.times do |i|
      mesh =  MushMesh.new("ember#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("ember#{i}-mat")
      mesh.mMake
    end
  end  

  def mFlaresCreate
    10.times do |i|
      mesh =  MushMesh.new("flare#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("flare#{i}-mat")
      mesh.mMake
    end
  end  

  def mStarsCreate
    10.times do |i|
      mesh =  MushMesh.new("star#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("star#{i}-mat")
      mesh.mMake
    end
  end
    
  def mExploCreate
    8.times do |i|
      mesh =  MushMesh.new("explo#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("explo#{i}-mat")
      mesh.mMake
    end
  end  

  def mCosmosCreate
    @m_textureLibrary.mCosmos1Names.size.times do |i|
      mesh =  MushMesh.new("cosmos1-#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mMaterialAdd("cosmos1-#{i}-mat")
      mesh.mMake
    end
  end  

  def mRandomCosmosName
    num = rand(@m_textureLibrary.mCosmos1Names.size)
    "cosmos1-#{num}"
  end

  def mItemsCreate
    @m_textureLibrary.mBoxNames.each do |prefix|
      mesh = MushMesh.new("#{prefix}box1")
	    base1 = MushBasePrism.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mMaterialAdd("#{prefix}box1-mat")
      mesh.mMake
    end
  end

  def mBallsCreate
    10.times do |i|
      mesh =  MushMesh.new("ball#{i}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      mesh.mBaseAdd(base1)
      mesh.mBillboardRandomSet(true)
      mesh.mMaterialAdd("ball#{i}-mat")
      mesh.mMake
    end
  end
  
  def mRailsCreate
    10.times do |i|
      mesh =  MushMesh.new("rail#{i}")
      base1 = MushBasePrism.new(:order => 4)
      baseDisplacement1 = MushDisplacement.new(
        :scale => MushVector.new(0.141,0.141,0.1,1000),
        :offset => MushVector.new(0,0,0,-501)
      )
      mesh.mBaseAdd(base1)
      mesh.mBaseDisplacementAdd(baseDisplacement1)
      mesh.mMaterialAdd("rail#{i}-mat")
      mesh.mMake
    end
  end
  
  def mDamageFramesCreate
    ['nuke_splash'].each do |prefix|
      mesh = MushMesh.new("#{prefix}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      baseDisplacement1 = MushDisplacement.new(
        :scale => MushVector.new(1000, 1000, 1000, 1000)
      )
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mBaseDisplacementAdd(baseDisplacement1)
      mesh.mMaterialAdd("no-render-mat")
      mesh.mMake
    end
  end
  
  def mCreate
    mKhaziRailCreate('rail')
    mKhaziRailCreate('rail-red')
    mKhaziRailCreate('rail-blue')
    mAttendantCreate('attendant')
    mAttendantCreate('attendant-red')
    mAttendantCreate('attendant-blue')
    
    mCubesCreate
    mProjectileCreate
    mWorldCreate
    mStarsCreate
    mEmbersCreate
    mFlaresCreate
    mExploCreate
    mCosmosCreate
    mPlayerCreate
    mItemsCreate
    mBallsCreate
    mRailsCreate
    mDamageFramesCreate
  end
end
