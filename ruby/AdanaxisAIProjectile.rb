#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIProjectile.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } YNRxyoroF56Ueof+iUvYlA
# $Id: AdanaxisAIProjectile.rb,v 1.4 2007/04/18 09:21:51 southa Exp $
# $Log: AdanaxisAIProjectile.rb,v $
# Revision 1.4  2007/04/18 09:21:51  southa
# Header and level fixes
#
# Revision 1.3  2007/04/16 08:41:05  southa
# Level and header mods
#
# Revision 1.2  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.1  2006/11/12 20:09:54  southa
# Missile guidance
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'

class AdanaxisAIProjectile < AdanaxisAI

  def mStateActionProjectileSeek
    onTarget = false
    unless @m_targetID
      # No target to seek
      mStateChange(AISTATE_IDLE)
    else
      begin
        targetPiece = MushGame.cPieceLookup(@m_targetID)
        targetPos = targetPiece.post.position
        onTarget = MushUtil.cMissileSeek(@r_post,
          targetPos, # Target
          @m_seekSpeed, # Maximum speed
          @m_seekAcceleration # Acceleration
        )
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end
    
    100
  end


  def mActMain
    case @m_state
      when AISTATE_IDLE
        callInterval = nil
      when AISTATE_DORMANT
        mStateChange(AISTATE_PROJECTILE_SEEK)
        callInterval = 100
      when AISTATE_PROJECTILE_SEEK
        callInterval = mStateActionProjectileSeek
      else callInterval = super 
    end

    callInterval
  end

end
