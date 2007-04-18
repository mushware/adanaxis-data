#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisAIKhaziHarpik.rb
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
#%Header } NPNGLY1+dq16kMgllVanKg
# $Id: AdanaxisAIKhaziHarpik.rb,v 1.1 2007/03/28 14:45:45 southa Exp $
# $Log: AdanaxisAIKhaziHarpik.rb,v $
# Revision 1.1  2007/03/28 14:45:45  southa
# Level and AI standoff
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziHarpik < AdanaxisAIKhazi
  
  def mWeaponChoose
    if @m_targetID
      targetPiece = MushGame.cPieceLookup(@m_targetID)
      targetDist2 = (targetPiece.post.position - @r_post.position).mMagnitudeSquared
      if targetDist2 > 10000
        @r_piece.mWeaponChange(:khazi_harpik_long)
      else
        @r_piece.mWeaponChange(:khazi_harpik_short)
      end
    end
  end

  def mFire
    mWeaponChoose
    super
  end

  def mStateActionIdle
    mStateChangeSeek(10000)
  end

  def mStateActionEvadeExit
    mStateChangeSeek(10000)
  end
  
  def mStateActionRamExit
    mStateChangeEvade(3000)
  end

  def mStateActionPatrolExit
    mStateChangeSeek(15000)
  end

  def mStateActionSeekExit
    mStateChangeEvade(3000)
  end

  def mStateActionWaypointExit
    mStateChangeSeek(10000)
  end

end
