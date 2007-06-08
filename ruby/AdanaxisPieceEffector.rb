#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceEffector.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.3, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 7ky2F4mlY59mOd1Z/8r/dg
# $Id: AdanaxisPieceEffector.rb,v 1.11 2007/06/06 12:24:13 southa Exp $
# $Log: AdanaxisPieceEffector.rb,v $
# Revision 1.11  2007/06/06 12:24:13  southa
# Level 22
#
# Revision 1.10  2007/05/22 16:44:58  southa
# Level 18
#
# Revision 1.9  2007/05/22 12:59:08  southa
# Vortex effect on player
#
# Revision 1.8  2007/05/21 17:04:42  southa
# Player effectors
#
# Revision 1.7  2007/05/21 13:32:51  southa
# Flush weapon
#
# Revision 1.6  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.5  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.4  2007/03/21 11:56:05  southa
# Rail effects and damage icons
#
# Revision 1.3  2007/03/13 21:45:08  southa
# Release process
#
# Revision 1.2  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.1  2006/11/03 18:46:31  southa
# Damage effectors
#

class AdanaxisPieceEffector < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "e"
    super
    @m_owner = inParams[:owner] || ""
    @m_lifeMsec = inParams[:lifetime_msec] || 0
    @m_rail = inParams[:rail] || false
    @m_isFlush = inParams[:is_flush] || false
    
    if @m_isFlush
      @m_callInterval = 100
    else
      @m_callInterval = nil
    end
    
    return @m_callInterval 
  end
  
  mush_accessor :m_rail, :m_owner
  
  def mDamageFactor(inPiece)
    if @m_rail
      retVal = @m_damageFactor
    else
      separation = (mPost.position - inPiece.mPost.position).mMagnitude
      factor = ((@m_hitPoints - separation) / @m_hitPoints).mClamp(0.0, 1.0)
      factor *= factor * factor # 4D so inverse cube law
      retVal = @m_damageFactor * factor
    end
    retVal
  end

  def mFlushEffect
    flarePost = mPost.dup
    
    flareOffset = MushTools.cRandomUnitVector * (5+rand(10))
    flareVel = flareOffset * -0.03

    flarePost.position = flarePost.position + flareOffset
    flarePost.velocity = flareVel
    
    $currentLogic.mEffects.mExploCreate(
      :post => flarePost,
      :explosion_lifetime_range => 600..600,
      :explosion_scale_range => 1.5..2.0,
      :alpha_stutter => 0
    )
  end
  
  def mActionTimer
    if @m_isFlush
      mLoad
      mFlushEffect
    end    
    @m_callInterval
  end

  
  def mCollisionHandle(event)
    if @m_isFlush
      unless event.mPiece2.mOriginalHitPoints > 500.0 # Don't move heavy objects
        distVec = event.mPiece2.mPost.position - mPost.position
        dist = distVec.mMagnitude
        dist = 10 if dist < 10
        angScale = 0.01 / dist
        distNorm = distVec * (1/dist)
        angAccel = MushTools.cRotationInXWPlane(distNorm.x*angScale)
        MushTools.cRotationInZWPlane(distNorm.y*angScale).mRotate(angAccel)
        MushTools.cRotationInYZPlane(distNorm.z*angScale).mRotate(angAccel)
        MushTools.cRotationInXYPlane(distNorm.w*angScale).mRotate(angAccel)
        angAccel.mNormalise!

        vel = event.mPiece2.mPost.velocity
        event.mPiece2.mPost.velocity = vel - distNorm * (0.2/dist)
        angVel = event.mPiece2.mPost.angular_velocity
        angAccel.mRotate(angVel)
        event.mPiece2.mPost.angular_velocity = MushTools::cSlerp(angVel, MushRotation.new, 0.01)
        
        if event.mPiece2.kind_of?(AdanaxisPiecePlayer)
          # Different behaviour for player
          event.mPiece2.mControlReleasedSet(true)
        end
      end
    elsif @m_rail
      # Rail impact effect
      if event.mCollisionPoint
        $currentLogic.mEffects.mFlareCreate(
          :post => MushPost.new(:position => event.mCollisionPoint),
          :flare_lifetime_range => 400..500,
          :flare_scale_range => 8.0..9.0,
          :alpha_stutter => 0.5
        )
        $currentLogic.mEffects.mExplode(
          :post => MushPost.new(:position => event.mCollisionPoint),
          :effect_scale => 1.0,
          :embers => 10,
          :ember_speed_range => 0.1..0.2,
          :explosions => 0,
          :flares => 1,
          :flare_lifetime_range => 900..1000,
          :flare_scale_range => 2.0..2.1
        )
      end
    end
  end
end
