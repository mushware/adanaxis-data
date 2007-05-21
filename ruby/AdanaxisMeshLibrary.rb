#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisMeshLibrary.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.3, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } WbjKV0UNx6NxJkbQBQ14fA
# $Id: AdanaxisMeshLibrary.rb,v 1.39 2007/05/10 11:44:11 southa Exp $
# $Log: AdanaxisMeshLibrary.rb,v $
# Revision 1.39  2007/05/10 11:44:11  southa
# Level15
#
# Revision 1.38  2007/05/08 15:28:13  southa
# Level 12
#
# Revision 1.37  2007/05/01 16:40:06  southa
# Level 10
#
# Revision 1.36  2007/04/26 13:12:39  southa
# Limescale and level 9
#
# Revision 1.35  2007/04/20 12:07:08  southa
# Khazi Warehouse and level 8
#
# Revision 1.34  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.33  2007/03/28 14:45:45  southa
# Level and AI standoff
#
# Revision 1.32  2007/03/23 12:27:34  southa
# Added levels and Cistern mesh
#
# Revision 1.31  2007/03/13 21:45:08  southa
# Release process
#
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
  # Drone mesh
  #
  # Cannon fodder, does nothing
  def mDroneCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 5))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,0),
      :scale => MushVector.new(Math.sqrt(2),Math.sqrt(2),1,1)
	  ))
	
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-0.5,0),
        :scale => 0.75
      ),
		  :num_iterations => 1
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0.5,0),
        :scale => 0.75
      ),
      :num_iterations => 1
    ))
	  
    # Nose
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1),
        :scale => 0.9),
  		:num_iterations => 2
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.0),
        :scale => 0.9),
  		:num_iterations => 2
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
  # Cistern mesh
  #
  # A large carrier that spawns smaller craft as it goes along
  def mKhaziCisternCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 7))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,1),
      :scale => MushVector.new(4*Math.sqrt(2),4*Math.sqrt(2),4,4)
	  ))
	
  	  
    # Nose
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1.5),
        :scale => 0.8),
  		:num_iterations => 1
    ))

    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1*11+0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1.0),
        :scale => 0.5),
  		:num_iterations => 1
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.5),
        :scale => 0.75),
  		:num_iterations => 1
    ))
  
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3*10+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,2.0),
        :scale => 1.0),
  		:num_iterations => 1
    ))
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 4*10+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.5),
        :scale => 1.25),
  		:num_iterations => 1
    ))

    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-3.0,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/12),
        :scale => 0.5
      ),
		  :num_iterations => 4
    ))
    
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,3.0,0),
        :rotation => MushTools.cRotationInZWPlane(Math::PI/12),
        :scale => 0.5
      ),
      :num_iterations => 4
    ))


    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end

  #
  # Khazi Floater mesh
  #
  # Smart mine
  #
  def mKhaziFloaterCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 5))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,0),
      :scale => MushVector.new(Math.sqrt(2),Math.sqrt(2),1,1) * 2
	  ))
	
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-1,0),
        :scale => 0.5
      ),
		  :num_iterations => 1
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,1,0),
        :scale => 0.5
      ),
      :num_iterations => 1
    ))
	  
    # Nose
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-2),
        :scale => 0.7),
  		:num_iterations => 2
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,2),
        :scale => 0.7),
  		:num_iterations => 2
    ))

    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end

  #
  # Khazi Freshener
  #
  # Inert khazi carrying a radiated countermeasure
  #
  def mKhaziFreshenerCreate(inName)
  
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 4))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,0),
      :scale => MushVector.new(2*Math.sqrt(2),2*Math.sqrt(2),2,2)
	  ))
	
    arms = 2.0
    scale = 0.8
    iter = 5
  
    # Boom -x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 6,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(-arms,0,0,0),
        :rotation => MushTools.cRotationInXWPlane(-Math::PI/32),
        :scale => scale
      ),
		  :num_iterations => iter
    ))
	  
    # Boom +x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 4,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(arms,0,0,0),
        :rotation => MushTools.cRotationInXWPlane(Math::PI/32),
        :scale => scale
      ),
      :num_iterations => iter
    ))
	  
    # Boom -y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,-arms,0,0),
        :rotation => MushTools.cRotationInYWPlane(-Math::PI/32),
        :scale => scale
      ),
		  :num_iterations => iter
    ))
	  
    # Boom +y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 5,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,arms,0,0),
        :rotation => MushTools.cRotationInYWPlane(Math::PI/32),
        :scale => scale
      ),
      :num_iterations => iter
    ))
	  
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-arms,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/32),
        :scale => scale
      ),
		  :num_iterations => iter
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,arms,0),
        :rotation => MushTools.cRotationInZWPlane(Math::PI/32),
        :scale => scale
      ),
      :num_iterations => iter
    ))

    # Boom -w
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-arms),
        :scale => scale),
  		:num_iterations => iter
    ))
  
    # Boom +w
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,arms),
        :scale => scale),
  		:num_iterations => iter
    ))

    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end

  #
  # Harpik mesh
  #
  # General purpose, and more dangerous than the Attendant
  def mKhaziHarpikCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 3))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,1),
      :scale => MushVector.new(2,2,2,2)
	  ))
	
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-1.0,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/6),
        :scale => 0.75
      ),
		  :num_iterations => 6
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,1.0,0),
        :rotation => MushTools.cRotationInZWPlane(Math::PI/6),
        :scale => 0.75
      ),
      :num_iterations => 6
    ))
	  
    # Nose
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1.5),
        :scale => 0.6),
  		:num_iterations => 4
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.5),
        :scale => 1.25),
  		:num_iterations => 1
    ))

    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end
  
  #
  # Vendor mesh
  #
  # A rcoket-firing khazi
  def mKhaziVendorCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 4))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,2),
      :scale => MushVector.new(2*Math.sqrt(2),2*Math.sqrt(2),2,4)
	  ))
	
    arms = 2.0
  
    # Nose 1
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-2),
        :scale => 0.7),
  		:num_iterations => 2
    ))
    
    # Nose 2
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 8+7,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-2),
        :scale => 0.9),
  		:num_iterations => 2
    ))
  
    # Boom -x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 6,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(-arms,0,0,0),
        :scale => 0.8
      ),
		  :num_iterations => 1
    ))
	  
    # Boom +x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 4,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(arms,0,0,0),
        :scale => 0.8
      ),
      :num_iterations => 1
    ))
	  
    # Boom -y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,-arms,0,0),
        :scale => 0.8
      ),
		  :num_iterations => 1
    ))
	  
    # Boom +y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 5,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,arms,0,0),
        :scale => 0.8
      ),
      :num_iterations => 1
    ))
	  
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-arms,0),
        :scale => 0.8
      ),
		  :num_iterations => 1
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,arms,0),
        :scale => 0.8
      ),
      :num_iterations => 1
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,2.0),
        :scale => 0.7),
  		:num_iterations => 1
    ))

    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end
  
  #
  # Warehouse mesh
  #
  # A large transport ship carrying valuable cargo
  def mKhaziWarehouseCreate(inName)
    mesh = MushMesh.new(inName)

    mesh.mBaseAdd(MushBasePrism.new(:order => 6))
	
    mesh.mBaseDisplacementAdd(MushDisplacement.new(
		  :offset => MushVector.new(0,0,0,1),
      :scale => MushVector.new(3*Math.sqrt(2),2*Math.sqrt(2),3,4)
	  ))
	
  	  
    # Nose
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 0,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1.5),
        :scale => 0.8),
  		:num_iterations => 1
    ))

    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1*9+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1.0),
        :scale => 0.5),
  		:num_iterations => 1
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.5),
        :scale => 0.75),
  		:num_iterations => 1
    ))
  
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3*9+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,2.0),
        :scale => 0.8),
  		:num_iterations => 1
    ))
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 4*9+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.5),
        :scale => 1.0),
  		:num_iterations => 1
    ))
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 5*9+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,0.75),
        :scale => 1.25),
  		:num_iterations => 1
    ))

    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-1.0,0),
        :scale => 0.5
      ),
		  :num_iterations => 1
    ))
	  
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7*9+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-2.0,0),
        :scale => 0.8
      ),
		  :num_iterations => 1
    ))
	  
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7*9+11*1+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-1.0,0),
        :scale => 1/0.75
      ),
		  :num_iterations => 1
    ))
	  
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7*9+11*2+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-2.0,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/30),
        :scale => 1.0
      ),
		  :num_iterations => 1
    ))
    
    # Boom +z

    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,1.0,0),
        :scale => 0.5
      ),
		  :num_iterations => 1
    ))
    
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7*9+11*4+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,2.0,0),
        :scale => 0.8
      ),
		  :num_iterations => 1
    ))
	  
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7*9+11*5+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,1.0,0),
        :scale => 1/0.75
      ),
		  :num_iterations => 1
    ))
	  
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7*9+11*6+1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,2.0,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/30),
        :scale => 1.0
      ),
		  :num_iterations => 1
    ))
        
    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
  end

  #
  # Khazi Limescale
  #
  # Dangerous khazi
  #
  def mKhaziLimescaleCreate(inName)
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
        :offset => MushVector.new(0,0,0,-2),
        :scale => 0.9),
  		:num_iterations => 2
    ))
    
    # Nose 2
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 8+7,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,-1),
        :scale => 0.4),
  		:num_iterations => 2
    ))
  
    # Boom -x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 6,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(-arms,0,0,0),
        :rotation => MushTools.cRotationInXWPlane(-Math::PI/4),
        :scale => 0.5
      ),
		  :num_iterations => 3
    ))
	  
    # Boom +x
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 4,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(arms,0,0,0),
        :rotation => MushTools.cRotationInXWPlane(Math::PI/4),
        :scale => 0.5
      ),
      :num_iterations => 3
    ))
	  
    # Boom -y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 7,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,-arms,0,0),
        :rotation => MushTools.cRotationInYWPlane(-Math::PI/4),
        :scale => 0.5
      ),
		  :num_iterations => 3
    ))
	  
    # Boom +y
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 5,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,arms,0,0),
        :rotation => MushTools.cRotationInYWPlane(Math::PI/4),
        :scale => 0.5
      ),
      :num_iterations => 3
    ))
	  
    # Boom -z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 2,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,-arms,0),
        :rotation => MushTools.cRotationInZWPlane(-Math::PI/4),
        :scale => 0.5
      ),
		  :num_iterations => 3
    ))
	  
    # Boom +z
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 3,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,arms,0),
        :rotation => MushTools.cRotationInZWPlane(Math::PI/4),
        :scale => 0.5
      ),
      :num_iterations => 3
    ))

    # Tail
    mesh.mExtruderAdd(MushExtruder.new(
      :sourceface => 1,
      :displacement => MushDisplacement.new(
        :offset => MushVector.new(0,0,0,1.0),
        :scale => 0.5),
  		:num_iterations => 1
    ))

    mesh.mMaterialAdd("#{inName}-mat")

    mesh.mMake
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
  # Cleaner mesh
  #
  
  def mCleanerCreate
    mesh = MushMesh.new('cleaner')

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
  mesh.mMaterialAdd('cleaner-mat')

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
      case i
        when 3
          baseDisplacement1 = MushDisplacement.new(
            :scale => MushVector.new(3,3,3,3)
          )
        else
          baseDisplacement1 = MushDisplacement.new(
            :scale => MushVector.new(1,1,1,1)
          )
      end
      mesh.mBaseDisplacementAdd(baseDisplacement1)
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
    ['nuke_splash', 'flush_splash'].each do |prefix|
      mesh = MushMesh.new("#{prefix}")
      base1 = MushBaseSingleFacet.new(:order => 4)
      scale = case prefix
        when 'nuke_splash' : 1000
        else 200
      end
      baseDisplacement1 = MushDisplacement.new(
        :scale => MushVector.new(scale, scale, scale, scale)
      )
      mesh.mBaseAdd(base1)
      mesh.mBillboardSet(true)
      mesh.mBaseDisplacementAdd(baseDisplacement1)
      mesh.mMaterialAdd("no-render-mat")
      mesh.mMake
    end
  end
  
  def mCreate
    mDroneCreate('drone')
    mAttendantCreate('attendant')
    mAttendantCreate('attendant-red')
    mAttendantCreate('attendant-blue')
    mKhaziCisternCreate('cistern')
    mKhaziCisternCreate('cistern-red')
    mKhaziCisternCreate('cistern-blue')
    mKhaziFloaterCreate('floater')
    mKhaziFloaterCreate('floater-red')
    mKhaziFloaterCreate('floater-blue')
    mKhaziFreshenerCreate('freshener')
    mKhaziFreshenerCreate('freshener-red')
    mKhaziFreshenerCreate('freshener-blue')
    mKhaziLimescaleCreate('limescale')
    mKhaziLimescaleCreate('limescale-red')
    mKhaziLimescaleCreate('limescale-blue')
    mKhaziHarpikCreate('harpik')
    mKhaziHarpikCreate('harpik-red')
    mKhaziHarpikCreate('harpik-blue')
    mKhaziVendorCreate('vendor')
    mKhaziVendorCreate('vendor-red')
    mKhaziVendorCreate('vendor-blue')
    mKhaziWarehouseCreate('warehouse')
    mKhaziWarehouseCreate('warehouse-red')
    mKhaziWarehouseCreate('warehouse-blue')
    mKhaziRailCreate('rail')
    mKhaziRailCreate('rail-red')
    mKhaziRailCreate('rail-blue')
    
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
