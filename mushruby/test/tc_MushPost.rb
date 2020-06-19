#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/test/tc_MushPost.rb
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
#%Header } BXRXdtNsNfbW5bRMEXdLKA
# $Id: tc_MushPost.rb,v 1.3 2006/08/01 17:21:16 southa Exp $
# $Log: tc_MushPost.rb,v $
# Revision 1.3  2006/08/01 17:21:16  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:10  southa
# Pre-release updates
#

class TestMushPost < Test::Unit::TestCase
  def test_simple
    post1 = MushPost.new
	post2 = MushPost.new(
      :position => MushVector.new(1,2,3,4),
	  :angular_position => MushTools.cRotationInXYPlane(Math::PI/2),
	  :velocity => MushVector.new(0,0,0,-0.3),
	  :angular_velocity => MushTools.cRotationInZWPlane(Math::PI/20)
	)
	post3 = MushPost.new(
	  MushVector.new(1,2,3,4),
	  MushVector.new(0,0,0,-0.3),
	  MushTools.cRotationInZWPlane(Math::PI/2),
	  MushTools.cRotationInZWPlane(Math::PI/20)
	  )
	assert_raise(Exception) { MushPost.new(:not_a_param => 0) }

	assert_equal(post2.position, MushVector.new(1,2,3,4))
	assert_equal(post2.velocity, MushVector.new(0,0,0,-0.3))
	assert_equal(post2.angular_position, MushTools.cRotationInXYPlane(Math::PI/2))
	assert_equal(post2.angular_velocity, MushTools.cRotationInZWPlane(Math::PI/20))
	
	post1.position = MushVector.new(5,6,7,8)
	assert_equal(post1.position, MushVector.new(5,6,7,8))
	
	post1.velocity = MushVector.new(15,16,17,18)
	assert_equal(post1.velocity, MushVector.new(15,16,17,18))
	
	post1.angular_position = MushTools.cRotationInXZPlane(Math::PI/4)
	assert_equal(post1.angular_position, MushTools.cRotationInXZPlane(Math::PI/4))
	
	post1.angular_velocity = MushTools.cRotationInYWPlane(Math::PI/8)
	assert_equal(post1.angular_velocity, MushTools.cRotationInYWPlane(Math::PI/8))
	
  end
end
