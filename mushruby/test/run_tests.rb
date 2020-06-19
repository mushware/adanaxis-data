#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/test/run_tests.rb
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
#%Header } 59IiYMYnCHGK09BxX5ri3Q
# $Id: run_tests.rb,v 1.3 2006/08/01 17:21:14 southa Exp $
# $Log: run_tests.rb,v $
# Revision 1.3  2006/08/01 17:21:14  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:09  southa
# Pre-release updates
#

require 'test/unit/ui/console/testrunner'
require 'test/unit/testsuite'

require 'Mushware.rb'
require 'Adanaxis.rb'

$testNames = %w(
  BasePrism
  Vector
  Displacement
  Extruder
  GLFont
  Material
  Mesh
  MeshLibrary
  Post
  Rotation
  Tools
  Vector
)

$testNames.each { |name|
  require "test/tc_Mush#{name}.rb"
}

class Tests
  def self.suite
    suite = Test::Unit::TestSuite.new
	
	$testNames.each { |name|
      suite << eval("TestMush#{name}.suite")
	}
	return suite
  end
end
    
Test::Unit::UI::Console::TestRunner.run(Tests)
