#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisKhazi.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } Ku/ML6yrUJg0hv6m7ettyw
# $Id: AdanaxisKhazi.rb,v 1.2 2006/08/01 13:41:11 southa Exp $
# $Log: AdanaxisKhazi.rb,v $
# Revision 1.2  2006/08/01 13:41:11  southa
# Pre-release updates
#

class AdanaxisKhazi
# Class: AdanaxisKhazi
#
# Description:
#
# This object is used to define or reference a new Khazi object.
#
# Method: new
#
# Creates a new AdanaxisKhazi object.  
#
# Parameters:
#
# post - Position/velocity <MushPost>
# mesh_name - Name of a previously created <MushMesh>.  A warning will be generated no mesh name is supplied
#
# Parameters must be supplied as a hash.
#
# Returns:
#
# New AdanaxisKhazi object
#
# Default:
#
# The default constructor creates an object with zero-values positions and velocities,
# and no mesh.
#
# Example:
#
# (example)
# post1 = AdanaxisKhazi.new
# post2 = AdanaxisKhazi.new(
#   post => MushPost.new(
#     :position => MushVector.new(1,2,3,4),
#     :angular_position => MushTools.cRotationInXYPlane(Math::PI/2),
#     :velocity => MushVector.new(0,0,0,-0.3),
#     :angular_velocity => MushTools.cRotationInZWPlane(Math::PI/20)
#   ),
#   :mesh_name => 'mymesh'
# )
#
# (end)
#
# Method: post
#
# Returns:
#
# Position/velocity <MushPost>
#
# Method: post=
#
# Sets the position and velocity.
#
# Parameter:
#
# Position/velocity <MushPost>
#
# Group: Links
#- Wrapper file:doxygen/class_adanaxis_ruby_khazi.html
#- Implemetation file:doxygen/class_adanaxis_piece_khazi.html
end
