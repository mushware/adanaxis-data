require 'test/unit/ui/console/testrunner'
require 'test/unit/testsuite'

require 'test/tc_Mush4Val.rb'
require 'test/tc_MushDisplacement.rb'
require 'test/tc_MushExtrusion.rb'
require 'test/tc_MushMesh.rb'
require 'test/tc_MushMeshLibrary.rb'

class Tests
  def self.suite
    suite = Test::Unit::TestSuite.new
    suite << TestMush4Val.suite
    suite << TestMushDisplacement.suite
    suite << TestMushExtrusion.suite
	suite << TestMushMesh.suite
	suite << TestMushMeshLibrary.suite
	return suite
  end
end
    
Test::Unit::UI::Console::TestRunner.run(Tests)
