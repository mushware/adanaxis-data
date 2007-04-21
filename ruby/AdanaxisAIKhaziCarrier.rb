#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziCarrier.rb
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
#%Header } txxMP32rR1qcSjFQodkSuA
#
# $Id: AdanaxisAIKhaziCarrier.rb,v 1.5 2007/04/18 09:21:51 southa Exp $
# $Log: AdanaxisAIKhaziCarrier.rb,v $
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
