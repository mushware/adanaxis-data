#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIKhaziFloater.rb
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
#%Header } cumczqt5kG+ZU8dofHyRGA
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
