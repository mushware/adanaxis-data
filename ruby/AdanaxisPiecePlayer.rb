#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPiecePlayer.rb
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
#%Header } 1H+rLloObKxiiVjoIDjJFw
# $Id: AdanaxisPiecePlayer.rb,v 1.5 2006/10/30 19:36:38 southa Exp $
# $Log: AdanaxisPiecePlayer.rb,v $
# Revision 1.5  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.4  2006/10/30 17:03:50  southa
# Remnants creation
#
# Revision 1.3  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.2  2006/10/04 13:35:21  southa
# Selective targetting
#
# Revision 1.1  2006/10/02 17:25:03  southa
# Object lookup and target selection
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'
require 'AdanaxisEvents.rb'

class AdanaxisPiecePlayer < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install
  
  def initialize(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "p"
    super
    @m_hitPoints = inParams[:hit_points] || 100.0
    @m_originalHitPoints = @m_hitPoints
    @m_shield = inParams[:shield] || 0.0
    @m_originalShield = 100.0

    @m_callInterval = 100
  end
  
  mush_accessor :m_shield, :m_originalShield
  
  def mShieldRatio
    @m_shield / @m_originalShield
  end
  
  def mVulnerability
    vuln = ((150.0 - @m_shield) / 150.0) - 0.2
    vuln = 0.0 if vuln < 0.0
    vuln = 1.0 if vuln > 1.0 || @m_shield == 0
    
    return vuln
  end
  
  def mDamageTake(inDamage)
    @m_shield -= inDamage
    @m_shield = 0.0 if @m_shield < 0.0
    super
  end
  
  def mActionTimer
    mLoad
    $currentGame.mView.mDashboard.mUpdate(
      :hit_point_ratio => mHitPointRatio,
      :shield_ratio => mShieldRatio
      )

    @m_callInterval
  end
  
  def mCollectItem(inItem)
    $currentLogic.mRemnant.mCollect(inItem, self)
  end
  
  def mCollisionHandle(event)
    super
    
    
    case event.mPiece2
      when AdanaxisPieceItem:
        mCollectItem(event.mPiece2)
        event.mPiece2.mExpireFlagSet(true)
    end
  end
  
end
