#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziLimescale.rb
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
#%Header } Ko1ziG/Ox4t+mgFNStOHJw
#
# $Id: AdanaxisAIKhaziLimescale.rb,v 1.1 2007/05/01 16:40:05 southa Exp $
# $Log: AdanaxisAIKhaziLimescale.rb,v $
# Revision 1.1  2007/05/01 16:40:05  southa
# Level 10
#
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziLimescale < AdanaxisAIKhazi
  def initialize(inParams = {})
    super
    @m_onTargetCount = 0
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
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end
    
    if onTarget
      @m_onTargetCount += 1
      if @m_onTargetCount > 10
        mFire
        mStateChangeEvade(6000)
      end
    else
      @m_onTargetCount = 0
    end
    
    100
  end

  def mStateActionDormantExit
    mStateChangeEvade(3000)
  end

  def mStateActionIdle
    mStateChangeSeek(10000)
  end

  def mStateActionEvadeExit
    mStateChangeSeek(10000)
  end
  
  def mStateActionRamExit
    mStateChangeEvade(6000)
  end

  def mStateActionPatrolExit
    mStateChangeSeek(15000)
  end

  def mStateActionSeekExit
    mStateChangeEvade(6000)
  end

  def mStateActionWaypointExit
    mStateChangeSeek(10000)
  end

end
