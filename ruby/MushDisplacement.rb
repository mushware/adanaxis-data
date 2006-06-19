
class MushDisplacement
# Class: MushDisplacement
#
# Description:
#
# This object contains an offset vector, a rotation and a scale vector.
# When the displacement is applied to a vertex, the vertex becomes:
#: offset + rotation applied-to (vertex elementwise-multiplied-by scale)
#
# 
# Method: new
#
# Creates a MushDisplacement object
#
# Parameters:
#
# offset - <MushVector> offset
# rotation - <MushRotation> rotation
# scale - either <MushVector> or singel value (which is converted to <MushVector.new>(value,value,vallue,value)
#
# Parameters may be supplied as a hash or parameter list.
#
# Returns:
#
# New MushDisplacement object
#
# Default:
#
# The default constructor creates the identity, i.e. a displacement which has no effect.
#
# Example:
#
# (example)
#   disp1 = MushDisplacement.new()
#
#	disp2 = MushDisplacement.new(
#     :offset => MushVector.new(1,0,0,0),
#     :rotation => MushTools.sRotationInZWPlane(Math::PI/2),
#     :scale => 0.3)
#
#	disp3 = MushDisplacement.new(
#     :scale => MushVector.new(0.5,1,1,1))
# (end)
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_displacement.html
#- Implemetation file:doxygen/class_mush_mesh_displacement.html

end

