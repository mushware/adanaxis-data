#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushRotation.rb
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
#%Header } TuiQntGkmhTVI3R5dN7fNw
# $Id: MushRotation.rb,v 1.4 2006/08/01 17:21:13 southa Exp $
# $Log: MushRotation.rb,v $
# Revision 1.4  2006/08/01 17:21:13  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:08  southa
# Pre-release updates
#

class MushRotation
# Class: MushRotation
#
# Description:
#
# This object contains a 4D rotation, which can be used to rotate vectors or other rotations.
#
# Method: new
#
# Creates a new MushRotation object.
#
# Parameters:
#
# None.
#
# Returns:
#
# New MushRotation object.
#
# Default:
#
# The MushRotation object returned by new is the identity i.e. provides zero rotation.
# Non-zero rotations can be obtained from the <MushTools> object.
#
# Example:
#
# (example)
# rotation1 = MushTools.cRotationInXYPlane(Math::PI/2)
# (end)
#
# Method: mRotate
#
# Applies the rotation to another object.
#
# Returns:
#
# None.
#
# Paramaters:
#
# This method takes either a vector or another rotation as a parameter.  If the parameter
# is a <MushVector>, it rotates the vector.  If another <MushRotation>, the parameter
# is set to a combination of the original rotation followed by this rotation.
#
# Example:
#
# (example)
# vec1 = MushVector.new(1,0,0,0)
# rot1 = MushTools.cRotationInXYPlane(Math::PI/2)
# rot1.mRotate(vec1)
# # vec1 is now (0,1,0,0)
#
# vec1 = MushVector.new(1,0,0,0)
# rot1 = MushTools.cRotationInXYPlane(Math::PI/2)
# rot2 = MushTools.cRotationInYZPlane(Math::PI/2)
# rot2.mRotate(rot1)
# # rot1 is now a rotation that applies the original rot1 then rot2
# rot1.mRotate(vec1)
# # vec1 is now (0,0,1,0)
# (end)
#
# Method: ==
#
# Tests whether two rotations are equal.
#
# Returns:
#
# Boolean.
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_rotation.html
#- Implemetation file:doxygen/class_mush_mesh_quaternion_pair.html
end
