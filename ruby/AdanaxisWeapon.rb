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
# $Id: AdanaxisWeapon.rb,v 1.1 2006/11/01 13:04:21 southa Exp $
# $Log: AdanaxisWeapon.rb,v $
# Revision 1.1  2006/11/01 13:04:21  southa
# Initial weapon handling
#

class AdanaxisWeapon < MushObject
  @@c_defaultOffset = [MushVector.new(0,0,0,0)]

  def initialize(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_projectileMesh = inParams[:projectile_mesh]
    @m_lifetimeMsec = inParams[:lifetime_msec] || 10000
    @m_speed = inParams[:speed] || 1.0
    @m_fireRateMsec = inParams[:fire_rate_msec] || 1000
    @m_offsetSequence = inParams[:offset_sequence] || @@c_defaultOffset
    @m_offsetNumber = 0
    @m_fireSound = inParams[:fire_sound]
    
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
  
  def mFire(inEvent, inPiece)
    projPost = inEvent.mPost.dup
    
    offset = @m_offsetSequence[@m_offsetNumber].dup
    vel = MushVector.new(0,0,0,-@m_speed)
    
    projPost.angular_position.mRotate(offset)
    projPost.angular_position.mRotate(vel)
    
    projPost.position = projPost.position + offset
    projPost.velocity = projPost.velocity + vel
    projPost.angular_velocity = MushRotation.new
    
    retVal = AdanaxisPieceProjectile.cCreate(
      :mesh_name => @m_projectileMesh,
      :post => projPost,
      :owner => inPiece.mId,
      :lifetime_msec => @m_lifetimeMsec
    )
    
    @m_lastFireMsec = MushGame.cGameMsec
    @m_offsetNumber += 1
    @m_offsetNumber = 0 if @m_offsetNumber >= @m_offsetSequence.size    
    
    
    MushGame.cSoundPlay(@m_fireSound, projPost) if @m_fireSound
    retVal
  end
end
