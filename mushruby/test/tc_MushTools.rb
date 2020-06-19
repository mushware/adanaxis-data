#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/test/tc_MushTools.rb
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
#%Header } 06aYeU0zAW4UpmKMV85UVQ
# $Id: tc_MushTools.rb,v 1.3 2006/08/01 17:21:16 southa Exp $
# $Log: tc_MushTools.rb,v $
# Revision 1.3  2006/08/01 17:21:16  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:10  southa
# Pre-release updates
#

require 'test/unit'
require 'MushTools.rb'

class TestMushTools < Test::Unit::TestCase
  def test_simple
    vec1 = MushVector.new(1,0,0,0)
    rot1 = MushTools.cRotationInXYPlane(Math::PI/2)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(0,1,0,0), 1e-6))
    rot1 = MushTools.cRotationInYZPlane(Math::PI/2)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(0,0,1,0), 1e-6))
    rot1 = MushTools.cRotationInZWPlane(Math::PI/2)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(0,0,0,1), 1e-6))
    rot1 = MushTools.cRotationInXWPlane(-Math::PI/2)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(1,0,0,0), 1e-6))
    rot1 = MushTools.cRotationInXZPlane(Math::PI/2)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(0,0,1,0), 1e-6))
    rot1 = MushTools.cRotationInYZPlane(-Math::PI/2)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(0,1,0,0), 1e-6))
    rot1 = MushTools.cRotationInYWPlane(Math::PI/2)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(0,0,0,1), 1e-6))

    vec1 = MushVector.new(1,0,0,0)
    rot1 = MushTools.cRotationInXYPlane(Math::PI/2)
    rot2 = MushTools.cRotationInYZPlane(Math::PI/2)

    # rot1 becomes a rotation that applies rot1 then rot2
    rot2.mRotate(rot1)
    rot1.mRotate(vec1)
    assert(vec1.mApproxEqual(MushVector.new(0,0,1,0), 1e-6))
  end
end

