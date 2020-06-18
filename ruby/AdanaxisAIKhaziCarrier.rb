#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIKhaziCarrier.rb
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
#%Header } 4ZJjolfI6NQwRaOxVA+g0w
#
# $Id: AdanaxisAIKhaziCarrier.rb,v 1.6 2007/04/21 18:05:46 southa Exp $
# $Log: AdanaxisAIKhaziCarrier.rb,v $
# Revision 1.6  2007/04/21 18:05:46  southa
# Level 8
#
# Revision 1.5  2007/04/18 09:21:51  southa
# Header and level fixes
#
# Revision 1.4  2007/03/27 14:01:02  southa
# Attendant AI
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziCarrier < AdanaxisAIKhazi

  AISTATE_DEPLOY=100

  def mStateChangeDeploy(inDuration = nil)
    mStateChangePatrol(inDuration)
    mStateChange(AISTATE_DEPLOY)
    nil
  end

  def mStateActionDormantExit
    mStateChangeDeploy(10000)
  end

  def mStateActionRamExit
    mStateChangeDeploy(10000)
  end

  def mStateActionPatrolExit
    mStateChangeDeploy(15000)
  end

  def mStateActionDeployExit
    if (@r_piece.mWeapon.mAmmoCount == 0 && AdanaxisRuby.cGameDifficulty > 0)
      mStateChangeRam(60000)
    else
      mStateChangePatrol(15000)
    end
  end

  def mStateActionDeploy
    retVal = mStateActionPatrol
    @r_piece.mFire
    retVal
  end
  
  def mActMain
    callInterval = 100

    case @m_state
      when AISTATE_DEPLOY
        callInterval = mStateActionDeploy
        mStateActionDeployExit if mStateExpired?
      else callInterval = super 
    end

    return callInterval
  end

end
