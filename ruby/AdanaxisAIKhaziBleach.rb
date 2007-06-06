#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziBleach.rb
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
#%Header } TdoZGIKi5If3xXDSlqFhng
#
# $Id$
# $Log$
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziBleach < AdanaxisAIKhazi
  
  def mStateActionIdle
    mStateChangeDormant(60000)
  end

  def mStateActionDormantExit
    mStateChangeSeek(60000)
  end
  
  def mStateActionEvadeExit
    mStateChangeSeek(60000)
  end
  
  def mStateActionRamExit
    mStateChangeRam(60000)
  end

  def mStateActionPatrolExit
    mStateChangeSeek(60000)
  end

  def mStateActionSeek
    onTarget = false
    mTargetSelect unless @m_targetID
    unless @m_targetID
      # No target to seek
      mStateChangeIdle
    else
      begin
        targetPiece = MushGame.cPieceLookup(@m_targetID)
        targetPos = targetPiece.post.position
        onTarget = MushUtil.cRotateAndSeek(@r_post,
          targetPos, # Target
          @m_seekSpeed, # Maximum speed
          @m_seekAcceleration, # Acceleration
          @m_seekStandOff # Stand off distance
        )
        # Don't fire unless close, as ammo limited
        targetDist2 = (targetPiece.post.position - @r_post.position).mMagnitudeSquared
        onTarget = false if targetDist2 > 100000
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end
    
    mFire if onTarget
    
    100
  end

  def mStateActionSeekExit
    mStateChangeSeek(60000)
  end

  def mStateActionWaypointExit
    mStateChangeSeek(60000)
  end
end
