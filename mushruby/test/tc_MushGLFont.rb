#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/test/tc_MushGLFont.rb
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
#%Header } sqOvzwvmRY4nNah5EOuCrQ
# $Id: tc_MushGLFont.rb,v 1.3 2006/08/01 17:21:15 southa Exp $
# $Log: tc_MushGLFont.rb,v $
# Revision 1.3  2006/08/01 17:21:15  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:09  southa
# Pre-release updates
#

class TestMushGLFont < Test::Unit::TestCase
  def test_simple
	font1 = MushGLFont.new(
      :name => 'font1',
      :texture_name => 'font1-tex',
      :divide => [8,12],
      :extent => [337/8.0, 768/12.0],
      :size => 0.05
    )
    
	font2 = MushGLFont.new(
      :name => 'font2',
      :texture_name => 'font2-tex',
      :divide => [8,12],
      :extent => [337/8.0, 768/12.0],
      :size => [0.04, 0.05]
    )
    
	assert_raise(Exception) { MushGLFont.new }
	assert_raise(Exception) { MushGLFont.new(5) }
	assert_raise(Exception) { MushGLFont.new(:not_a_param => 0) }
  end
end
