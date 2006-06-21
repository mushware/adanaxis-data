
class MushMesh
# Class: MushMesh
#
# Description:
#
# This object contains a 4D mesh definition, including vertices, faces, facets,
# together with objects which define how the mesh is generated.
#
# Example:
#
# (example)
# mesh = MushMesh.new('mymesh')
# mesh.mAddBase(MushBasePrism.new( ... ))
# mesh.mAddBaseDisplacement(MushDisplacement.new( ... ))
# mesh.mAddExtruder(MushExtruder.new( ... ))
# mesh.mAddExtruder(MushExtruder.new( ... ))
# mesh.mAddMaterial('material1')
# mesh.mMake
# (end)
#
# Method: new
#
# Creates a new, empty mesh object.  
#
# Parameters:
#
# Mesh name.
#
# Returns:
#
# New MushMesh object.
#
# Default:
#
# The default constructor creates an empty mesh.
#
# Method: mMake
#
# Creates the mesh, based on the base and extruders, etc. added.  Must be called
# before the mesh can be used.
#
# Parameters:
#
# None
#
# Method: mAddBase
#
# Adds a MushBase object to the mesh.  This is used as the base object.  Typically
# the base object is simple and its faces are extruded to produce a more complex mesh.
#
# Parameters:
#
# object - Subclass of <MushBase>
#
# Method: mAddBaseDisplacement
#
# Adds a MushDisplacement object to the mesh.  This is applied to the base object
# to position and scale it.
#
# Parameters:
#
# object - <MushDisplacement>
#
# Method: mAddExtruder
#
# Adds a <MushExtruder> object to the mesh.  Extrusions will be applied in the
# order in which they are added.
#
# Parameters:
#
# object - <MushExtruder>
#
# Method: mAddMaterial
#
# Adds a <MushMaterial> reference to the mesh.  Materials define the material (textures,
# lighting, etc) to be used when the mesh is rendered.
#
# Parameters:
#
# name - Name of the material to be added, previously created using <MushMaterial.cDefine>
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_mesh.html
#- Implemetation file:doxygen/class_mush_mesh4_mesh.html
end
