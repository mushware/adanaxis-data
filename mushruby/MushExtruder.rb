#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushExtruder.rb
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
#%Header } lOobYImIqIXE1FuHhAsL5g
# $Id: MushExtruder.rb,v 1.4 2006/08/01 17:21:12 southa Exp $
# $Log: MushExtruder.rb,v $
# Revision 1.4  2006/08/01 17:21:12  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:06  southa
# Pre-release updates
#

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
# num_iterations - Number of times to copy and displace the face
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
