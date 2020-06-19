#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushMesh.rb
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
#%Header } z9qAGyK4+OPFOuDctvyBbg
# $Id: MushMesh.rb,v 1.4 2006/08/01 17:21:13 southa Exp $
# $Log: MushMesh.rb,v $
# Revision 1.4  2006/08/01 17:21:13  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:08  southa
# Pre-release updates
#

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
# Method: mBillboardSet
#
# Sets the billboard flag for the mesh.  If true, the mesh will always be rendered
# with the xy plane facing the camera.
#
# Parameters:
#
# billboard - true or false
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_mesh.html
#- Implemetation file:doxygen/class_mush_mesh4_mesh.html
end
