
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

