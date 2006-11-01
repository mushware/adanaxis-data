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
# $Id$
# $Log$

class AdanaxisWeapon < MushObject
  def initialize(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_projectileMesh = inParams[:projectile_mesh]
    @m_lifetimeMsec = inParams[:lifetime_msec] || 10000
    @m_speed = inParams[:speed] || 1.0
    @m_fireRateMsec = inParams[:fire_rate_msec] || 1000
    
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
    projPost = inEvent.post.dup
    
    vel = MushVector.new(0,0,0,-@m_speed)
    
    projPost.angular_position.mRotate(vel)
    
    projPost.velocity = projPost.velocity + vel
    projPost.angular_velocity = MushRotation.new
    
    retVal = AdanaxisPieceProjectile.cCreate(
      :mesh_name => @m_projectileMesh,
      :post => projPost,
      :owner => inPiece.mId,
      :lifetime_msec => @m_lifetimeMsec
    )
    
    @m_lastFireMsec = MushGame.cGameMsec
    
    retVal
  end
end
