#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIKhaziHarpik.rb
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
#%Header } C1Y7CuBffmTYk5zeRh/1Aw
# $Id: AdanaxisAIKhaziHarpik.rb,v 1.4 2007/06/27 12:58:09 southa Exp $
# $Log: AdanaxisAIKhaziHarpik.rb,v $
# Revision 1.4  2007/06/27 12:58:09  southa
# Debian packaging
#
# Revision 1.3  2007/04/21 18:05:46  southa
# Level 8
#
# Revision 1.2  2007/04/18 09:21:51  southa
# Header and level fixes
#
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
