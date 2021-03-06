#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIKhaziWarehouse.rb
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
#%Header } dnLjclE4S94D9YGLu8WxBA
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
