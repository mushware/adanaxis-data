#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushBasePrism.rb
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
#%Header } cPQ1Rf331ZEnze6S7u1WmA
# $Id: MushBasePrism.rb,v 1.3 2006/08/01 17:21:11 southa Exp $
# $Log: MushBasePrism.rb,v $
# Revision 1.3  2006/08/01 17:21:11  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:06  southa
# Pre-release updates
#

require 'MushBase.rb'

# Other methods provided by MushMeshRubyBasePrism.cpp
class MushBasePrism < MushBase
# Class: MushBasePrism
#
# Description:
#
# This object is used as a base shape for a <MushMesh> object, and provides a prism
# based on a regular polygon.  A 2D polygon is created with the requested number of sides,
# within a circle of radius 0.5.  This polygon is extruded to produce a 3D prism,
# and that 3D prism is again extruded to generate the 4D prism.
#
# Face numbering is as follows
#
# 0 - w = -0.5
# 1 - w = +0.5
# 2 - z = -0.5
# 3 - z = +0.5
# 4 - x = +k
# 5..(order+3) - rotating anticlockwise in the xy plane
#
# Example for order = 4
#
# 5 - y = +k
# 6 - x = -k
# 7 - y = -k
#
# where k becomes 0.5/sqrt(2) to contain the square within radius 0.5.
#
# Method: new
#
# Creates a BasePrism object, ready to add to a mesh.  
#
# Parameters:
#
# order - Number of sides of the initial polygon
#
# The parameter can be supplied as a single value or hash
#
# Returns:
#
# New MushBasePrism object
#
# Default:
#
# There is no default constructor.  The order parameter must be provided.
#
# Example:
#
# (example)
#   baseprism1 = MushBasePrism.new(5)
#   baseprism2 = MushBasePrism.new(:order => 5)
# (end)
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_base_prism.html
#- Implemetation file:doxygen/class_mush_mesh_library_prism.html

end
