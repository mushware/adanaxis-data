#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushTools.rb
#
# Copyright: Andy Southgate 2002-2007, 2020
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##############################################################################
#%Header } qOKINwaKjulPpNPVx7MnHw
# $Id: MushTools.rb,v 1.5 2007/03/13 21:45:03 southa Exp $
# $Log: MushTools.rb,v $
# Revision 1.5  2007/03/13 21:45:03  southa
# Release process
#
# Revision 1.4  2006/08/01 17:21:14  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:08  southa
# Pre-release updates
#

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
# New MushRotation object.
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
# New MushRotation object.
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
# New MushRotation object.
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
# New MushRotation object.
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
# New MushRotation object.
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
# New MushRotation object.
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
# New MushRotation object.
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRotationInYZPlane(Math::PI / 2)
# (end)
#
# Method: cRandomOrientation
#
# Creates a <MushRotation> object to be used as a random orientation.  
#
# Parameters:
#
# None.
#
# Returns:
#
# New MushRotation object.
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRandomOrientation
# (end)
#
# Method: cRandomUnitVector
#
# Returns a random unit vector.  
#
# Parameters:
#
# None.
#
# Returns:
#
# New <MushVector> object.
#
# Example:
#
# (example)
#   vector1 = MushTools.cRandomUnitVector()
# (end)
#
# Method: cRandomAngularVelocity
#
# Returns a random angular velocity.  The magnitude is determined by the parameter.
#
# Parameters:
#
# magnitude - approximate radian amplited of angular velocity
#
# Returns:
#
# New <MushRotation> object.
#
# Example:
#
# (example)
#   rotation1 = MushTools.cRandomAngularVelocity(0.01)
# (end)
#
# Method: cRandomSeedSet
#
# Sets the random seed for these value.
#
# Parameters:
#
# seed - interger seed value
#
# Returns:
#
# Bone.
#
# Example:
#
# (example)
#   MushTools.cRandomSeedSet(12)
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

