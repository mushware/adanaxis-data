
# Other methods provided by MushMeshRubyTools.cpp
class MushTools
# Class: MushTools
#
# Description:
#
# This object contains tools and utilities for <MushVector> and <MushRotation>
# manipulation.  It supplies only singleton methods.
#
# Method: cRotationInPlane
#
# Creates a rotation in the specified plane.  
#
# Parameters:
#
# plane - Any of the PLANE_XY constants
# angle - rotation angle in radians
#
# Returns:
#
# New MushRotation object
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInPlane(PLANE_YW, Math::PI / 2)
# (end)
#
# Method: cRotationInXYPlane
#
# Creates a rotation in the XY plane.  
#
# Parameters:
#
# angle - rotation angle in radians
#
# Returns:
#
# New MushRotation object
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInXYPlane(Math::PI / 2)
# (end)
#
# Method: cRotationInZWPlane
#
# Creates a rotation in the ZW plane.  
#
# Parameters:
#
# angle - rotation angle in radians
#
# Returns:
#
# New MushRotation object
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInZWPlane(Math::PI / 2)
# (end)
#
# Method: cRotationInXZPlane
#
# Creates a rotation in the XZ plane.  
#
# Parameters:
#
# angle - rotation angle in radians
#
# Returns:
#
# New MushRotation object
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInXZPlane(Math::PI / 2)
# (end)
#
# Method: cRotationInYWPlane
#
# Creates a rotation in the YW plane.  
#
# Parameters:
#
# angle - rotation angle in radians
#
# Returns:
#
# New MushRotation object
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInYWPlane(Math::PI / 2)
# (end)
#
# Method: cRotationInXWPlane
#
# Creates a rotation in the XW plane.  
#
# Parameters:
#
# angle - rotation angle in radians
#
# Returns:
#
# New MushRotation object
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInXWPlane(Math::PI / 2)
# (end)
#
# Method: cRotationInYZPlane
#
# Creates a rotation in the YZ plane.  
#
# Parameters:
#
# angle - rotation angle in radians
#
# Returns:
#
# New MushRotation object
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInYZPlane(Math::PI / 2)
# (end)
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_tools.html
#- Implemetation file:doxygen/class_mush_mesh_tools.html

  PLANE_XY = 0
  PLANE_ZW = 1
  PLANE_XZ = 2
  PLANE_YW = 3
  PLANE_XW = 4
  PLANE_YZ = 5
end

