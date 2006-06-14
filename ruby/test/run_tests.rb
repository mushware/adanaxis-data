require 'test/unit/ui/console/testrunner'
require 'test/unit/testsuite'

require 'Mushware.rb'
require 'Adanaxis.rb'

require 'test/tc_MushVector.rb'
require 'test/tc_MushDisplacement.rb'
require 'test/tc_MushExtruder.rb'
require 'test/tc_MushExtrusion.rb'
require 'test/tc_MushMesh.rb'
require 'test/tc_MushMeshLibrary.rb'
require 'test/tc_MushRotation.rb'
require 'test/tc_MushTools.rb'

class Tests
  def self.suite
    suite = Test::Unit::TestSuite.new
    suite << TestMushVector.suite
    suite << TestMushDisplacement.suite
    suite << TestMushExtruder.suite
    suite << TestMushExtrusion.suite
	suite << TestMushMesh.suite
	suite << TestMushMeshLibrary.suite
	suite << TestMushRotation.suite
	suite << TestMushTools.suite
	return suite
  end
end
    
Test::Unit::UI::Console::TestRunner.run(Tests)
