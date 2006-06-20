
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
