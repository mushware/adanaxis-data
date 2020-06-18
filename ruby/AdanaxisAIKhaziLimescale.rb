#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIKhaziLimescale.rb
#
# Copyright: Andy Southgate 2002-2007, 2020
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##############################################################################
#%Header } upFnSNPiXdwel1QS+oj/zQ
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
