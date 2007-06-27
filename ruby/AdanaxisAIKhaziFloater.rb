#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziFloater.rb
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
#%Header } 8GnoLvZ5qvKQjXs2RO3aTQ
#
# $Id: AdanaxisAIKhaziFloater.rb,v 1.1 2007/05/10 11:44:11 southa Exp $
# $Log: AdanaxisAIKhaziFloater.rb,v $
# Revision 1.1  2007/05/10 11:44:11  southa
# Level15
#
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziFloater < AdanaxisAIKhazi

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
        
        targetDist2 = (targetPos - @r_post.position).mMagnitudeSquared
        if targetDist2 < 400
          @r_piece.mDetonate
        elsif targetDist2 < 10000
          onTarget = MushUtil.cRotateAndSeek(@r_post,
            targetPos, # Target
            @m_seekSpeed, # Maximum speed
            @m_seekAcceleration # Acceleration
          )
        else
          # Decelerate
          @r_post.velocity = @r_post.velocity * 0.9
        end
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end
    
    100
  end

  def mStateActionDormantExit
    mStateChangeSeek(10000)
  end

  def mStateActionEvadeExit
    mStateChangeDormant(3000)
  end
  
  def mStateActionRamExit
    mStateChangeDormant(3000)
  end

  def mStateActionPatrolExit
    mStateChangeDormant(3000)
  end

  def mStateActionSeekExit
    mTargetSelect
    mStateChangeSeek(2000)
  end

  def mStateActionWaypointExit
    mStateChangeDormant(3000)
  end

end
