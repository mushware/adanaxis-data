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
