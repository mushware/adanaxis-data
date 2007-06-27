#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziWarehouse.rb
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
#%Header } UFXcFg3WpkRqgY0HgJ2cTQ
#
# $Id: AdanaxisAIKhaziWarehouse.rb,v 1.3 2007/05/29 13:25:56 southa Exp $
# $Log: AdanaxisAIKhaziWarehouse.rb,v $
# Revision 1.3  2007/05/29 13:25:56  southa
# Level 20
#
# Revision 1.2  2007/05/24 15:13:49  southa
# Level 17
#
# Revision 1.1  2007/04/20 12:07:07  southa
# Khazi Warehouse and level 8
#
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziWarehouse < AdanaxisAIKhazi

  def mTargetOverride(inTargetID)
    # Always ignore
  end
  
  def mStateActionIdle
    mStateChangeDormant(60000)
  end

  def mStateActionDormantExit
    mStateChangePatrol(60000)
  end
  
  def mStateActionEvadeExit
    mStateChangePatrol(60000)
  end
  
  def mStateActionRamExit
    mStateChangePatrol(60000)
  end

  def mStateActionPatrolExit
    mStateChangePatrol(60000)
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
        # Don't fire unless close.  Warehouse is always carrying items for transfer
        targetDist2 = (targetPiece.post.position - @r_post.position).mMagnitudeSquared
        onTarget = false if targetDist2 > 10000
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end
    
    mFire if onTarget
    
    100
  end

  def mStateActionSeekExit
    if mTargetID
      mStateChangeSeek(60000)
    end
  end

  def mStateActionWaypointExit
    mStateChangePatrol(60000)
  end

end
