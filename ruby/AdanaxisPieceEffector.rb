#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceEffector.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.2, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } LtQWSR6m3PweuJMSppQODg
# $Id: AdanaxisPieceEffector.rb,v 1.4 2007/03/21 11:56:05 southa Exp $
# $Log: AdanaxisPieceEffector.rb,v $
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
  end
  
  mush_accessor :m_rail
  
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

  def mCollisionHandle(event)
    if @m_rail
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
