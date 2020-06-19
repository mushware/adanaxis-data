#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/test/tc_MushBasePrism.rb
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
#%Header } 75UjN7I1Tely6hXLinMHiw
# $Id: tc_MushBasePrism.rb,v 1.3 2006/08/01 17:21:14 southa Exp $
# $Log: tc_MushBasePrism.rb,v $
# Revision 1.3  2006/08/01 17:21:14  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:09  southa
# Pre-release updates
#

class TestMushBasePrism < Test::Unit::TestCase
  def test_simple
    baseprism1 = MushBasePrism.new(5)
	baseprism1 = MushBasePrism.new(:order => 5)
	
	assert_raise(Exception) { MushBasePrism.new }
	assert_raise(Exception) { MushBasePrism.new(:not_a_param => 0) }

  end
end
