#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisWeapon.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } Xu79QXYia2BFmo2DZ89f+A
# $Id: AdanaxisWeapon.rb,v 1.7 2006/11/14 14:02:16 southa Exp $
# $Log: AdanaxisWeapon.rb,v $
# Revision 1.7  2006/11/14 14:02:16  southa
# Ball projectiles
#
# Revision 1.6  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.5  2006/11/12 14:39:50  southa
# Player weapons amd audio fix
#
# Revision 1.4  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.3  2006/11/02 12:23:21  southa
# Weapon selection
#
# Revision 1.2  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.1  2006/11/01 13:04:21  southa
# Initial weapon handling
#

class AdanaxisWeapon < MushObject
  @@c_defaultOffset = [MushVector.new(0,0,0,0)]
  @@c_defaultAngularVelocity = MushTools.cRotationInXYPlane(0.02)
  MushTools.cRotationInXZPlane(0.05).mRotate(@@c_defaultAngularVelocity)
  MushTools.cRotationInYZPlane(0.07).mRotate(@@c_defaultAngularVelocity)

  def initialize(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_projectileMesh = inParams[:projectile_mesh]
    @m_lifetimeMsec = inParams[:lifetime_msec] || 10000
    @m_speed = inParams[:speed] || 1.0
    @m_acceleration = inParams[:acceleration] || 0.0
    @m_speedLimit = inParams[:speed_limit] || 0.0
    @m_fireRateMsec = inParams[:fire_rate_msec] || 1000
    @m_offsetSequence = inParams[:offset_sequence] || @@c_defaultOffset
    @m_offsetNumber = 0
    @m_fireSound = inParams[:fire_sound]
    @m_reloadSound = inParams[:reload_sound]
    @m_angularVelocity = inParams[:angular_velocity] || @@c_defaultAngularVelocity
    @m_hitPoints = inParams[:hit_points] || 1.0
    @m_aiParams = inParams[:ai_params]
    @m_numProjectiles = inParams[:num_projectiles] || 1
    @m_deviation = inParams[:deviation]
    @m_rail = inParams[:rail]
    @m_lastFireMsec = 0
  end
  
  def mFireOpportunityTake
    retVal = false
    if @m_lastFireMsec + @m_fireRateMsec < MushGame.cGameMsec
      @m_lastFireMsec = MushGame.cGameMsec
      retVal = true
    end
    retVal
  end
  
  def mProjectileFire(inEvent, inPiece)
    projPost = inEvent.mPost.dup
    
    # Get player forward velocity but not transverse
    vel = projPost.velocity
    projPost.angular_position.mInverse.mRotate(vel)
    vel.x = 0
    vel.y = 0
    vel.z = 0
    vel.w = vel.w - @m_speed

    offset = @m_offsetSequence[@m_offsetNumber].dup
    
    projPost.angular_position.mRotate(offset)
    projPost.angular_position.mRotate(vel)
    
    projPost.position = projPost.position + offset
    projPost.velocity = vel
    
    # Apply the angular velocity in the object frame
    angVel = projPost.angular_position.mInverse
    @m_angularVelocity.mRotate(angVel)
    projPost.angular_position.mRotate(angVel)
    projPost.angular_velocity = angVel
    
    if @m_aiParams
      aiParams = @m_aiParams.merge(
        :target_id => inEvent.mTargetID
      )
    end
    
    baseVelocity = projPost.velocity
    lifetime = @m_lifetimeMsec
    @m_numProjectiles.times do
      projPost.velocity = baseVelocity + MushTools.cRandomUnitVector * @m_deviation if @m_deviation
      lifetime = @m_lifetimeMsec.begin + rand(@m_lifetimeMsec.end - @m_lifetimeMsec.begin) if @m_lifetimeMsec.kind_of?(Range)
      AdanaxisPieceProjectile.cCreate(
        :mesh_name => @m_projectileMesh,
        :post => projPost,
        :owner => inPiece.mId,
        :lifetime_msec => lifetime,
        :hit_points => @m_hitPoints,
        :acceleration => @m_acceleration,
        :speed_limit => @m_speedLimit,
        :ai_params => aiParams
      )
    end
    
    @m_lastFireMsec = MushGame.cGameMsec
    @m_offsetNumber += 1
    @m_offsetNumber = 0 if @m_offsetNumber >= @m_offsetSequence.size    
    
    MushGame.cSoundPlay(@m_fireSound, projPost) if @m_fireSound
    MushGame.cSoundPlay(@m_reloadSound, projPost) if @m_reloadSound
    nil
  end
  
  def mRailFire(inEvent, inPiece)
    projPost = inEvent.mPost.dup
    offset = @m_offsetSequence[@m_offsetNumber].dup
    
    
    # Apply the angular velocity in the object frame
    angVel = projPost.angular_position.mInverse
    @m_angularVelocity.mRotate(angVel)
    projPost.angular_position.mRotate(angVel)
    projPost.angular_velocity = angVel
    
    baseVelocity = projPost.velocity
    lifetime = @m_lifetimeMsec

    # Create the effector before applying the offset, so the gunsight works as expected
    AdanaxisPieceEffector.cCreate(
      :rail => true,
      :mesh_name => @m_projectileMesh,
      :post => projPost,
      :owner => inPiece.mId,
      :lifetime_msec => 0,
      :hit_points => @m_hitPoints,
      :vulnerability => 0.0
    )

    projPost.angular_position.mRotate(offset)
    projPost.position = projPost.position + offset

    AdanaxisPieceDeco.cCreate(
      :mesh_name => @m_projectileMesh,
      :post => projPost,
      :lifetime_msec => lifetime
    )
      

    
    @m_lastFireMsec = MushGame.cGameMsec
    @m_offsetNumber += 1
    @m_offsetNumber = 0 if @m_offsetNumber >= @m_offsetSequence.size    
    
    MushGame.cSoundPlay(@m_fireSound, projPost) if @m_fireSound
    MushGame.cSoundPlay(@m_reloadSound, projPost) if @m_reloadSound
    nil
  end
  
  def mFire(inEvent, inPiece)
    if @m_rail
      mRailFire(inEvent, inPiece)
    else
      mProjectileFire(inEvent, inPiece)
    end
  end
end
