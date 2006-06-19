
class TestMushMaterial < Test::Unit::TestCase
  def test_simple
    MushMaterial.cDefine(
	    :name => 'testmaterial1',
	    :texture_name => 'testtex1'
		)
		
	assert_raise(Exception) {
	    MushMaterial.cDefine(
	    :name => 'testmaterial1',
	    :texture_name => 'testtex1',
		:not_a_param => 1
		)
	}

	assert_raise(Exception) {
	    MushMaterial.cDefine(
	    :name => 'testmaterial1'
		)
    }
  end
end
