#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushPost.rb
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
#%Header } zz3tC8hIdMRRPThT6R+GQw
# $Id: MushPost.rb,v 1.4 2006/08/01 17:21:13 southa Exp $
# $Log: MushPost.rb,v $
# Revision 1.4  2006/08/01 17:21:13  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:08  southa
# Pre-release updates
#

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
# Creates a new MushPost object.  
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
