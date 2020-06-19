#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushDisplacement.rb
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
#%Header } E5dCR+Ootftkl4F79atPqA
# $Id: MushDisplacement.rb,v 1.3 2006/08/01 17:21:11 southa Exp $
# $Log: MushDisplacement.rb,v $
# Revision 1.3  2006/08/01 17:21:11  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:06  southa
# Pre-release updates
#

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
# scale - either a <MushVector> or single value (which is converted to <MushVector.new>(value,value,value,value)
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

