
class MushPost
# Class: MushPost
#
# Description:
#
# This object contains position and velocity <MushVectors>, and angular position
# and velocity <MushRotations>.
#
# Method: new
#
# Creates an new MushPost object.  
#
# Parameters:
#
# position - Position <MushVector>
# velocity - Velocity <MushVector>
# angular_position - Angular position <MushRotation>
# angular_velocity - Angular velocity <MushRotation>
#
# Parameters may be supplied as a hash, or as four parameters.
#
# Returns:
#
# New MushPost object
#
# Default:
#
# The default constructor creates an object with zero-values positions and velocities.
#
# Example:
#
# (example)
# post1 = MushPost.new
# post2 = MushPost.new(
#   :position => MushVector.new(1,2,3,4),
#   :angular_position => MushTools.cRotationInXYPlane(Math::PI/2),
#   :velocity => MushVector.new(0,0,0,-0.3),
#   :angular_velocity => MushTools.cRotationInZWPlane(Math::PI/20)
# )
# post3 = MushPost.new(
#   MushVector.new(1,2,3,4),
#   MushVector.new(0,0,0,-0.3),
#   MushTools.cRotationInZWPlane(Math::PI/2),
#   MushTools.cRotationInZWPlane(Math::PI/20)
# )
# (end)
#
# Method: position
#
# Returns:
#
# Position <MushVector>
#
# Method: velocity
#
# Returns:
#
# Velocity <MushVector>
#
# Method: angular_position
#
# Returns:
#
# Angular position <MushRotation>
#
# Method: angular_velocity
#
# Returns:
#
# Angular velocity <MushRotation>
#
# Method: position=
#
# Sets the position vector.
#
# Parameter:
#
# Position <MushVector>
# 
# Method: velocity=
#
# Sets the velocity vector.
#
# Parameter:
#
# Velocity <MushVector>
# 
# Method: angular_position=
#
# Sets the angular position element.
#
# Parameter:
#
# Angular position <MushRotation>
# 
# Method: angular_velocity=
#
# Sets the angular velocity element.
#
# Parameter:
#
# Angular velocity <MushRotation>
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_post.html
#- Implemetation file:doxygen/class_mush_mesh_posticity.html
end
