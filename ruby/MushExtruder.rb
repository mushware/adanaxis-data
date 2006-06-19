
# Other methods provided by MushMeshRubyExtruder.cpp
class MushExtruder

# Class: MushExtruder
#
# Description:
#
# This object specifies an extrusion.  An extrusion is an operation on an object
# that takes one face and creates a 'tube' based on that face.  To use, the
# extruder should be added to a <MushMesh> object.
#
# Method: new
#
# Creates an extruder object, ready to add to a mesh.  
#
# Parameters:
#
# sourceface - Number of the face used for the base of this extrusion
# displacement - <MushDisplacement> applied to the source face to generate the extruded face
# displacement_velocity - <MushDisplacement> applied to displacement after each extrusion
# num_iterations - Number of times to copy and diplace the face
# to_point - Whether the final step extrudes to a point
#
# Returns:
#
# New MushExtruder object
#
# Default:
#
# The default constructor creates an extrusion with which has no effect.
#
# Example:
#
# (example)
#   extruder1 = MushExtruder.new(
#     :sourceface => 0,
#     :displacement => MushDisplacement.new(
#       :offset => MushVector.new(1,0,0,0),
#       :rotation => MushTools.sRotationInZWPlane(Math::PI/2),
#       :scale => 1.0),
#     :displacement_velocity => MushDisplacement.new(MushVector.new(1,0,0,0), MushRotation.new, 0.5)
#     :num_iterations => 3,
#     :to_point => true
#   )
# (end)
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_extruder.html
#- Implemetation file:doxygen/class_mush_mesh_library_extruder.html

end
