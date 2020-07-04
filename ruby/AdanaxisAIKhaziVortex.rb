#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIKhaziVortex.rb
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
#%Header } Aj8D26yO4LQI0MSji5ERNA
#
# $Id: AdanaxisAIKhaziVortex.rb,v 1.2 2007/06/12 11:09:35 southa Exp $
# $Log: AdanaxisAIKhaziVortex.rb,v $
# Revision 1.2  2007/06/12 11:09:35  southa
# Level 28
#
# Revision 1.1  2007/05/21 13:32:51  southa
# Flush weapon
#
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziVortex < AdanaxisAIKhazi

  def mStateActionDormantExit
    mStateChangeEvade(3000)
  end
  
  def mStateActionIdle
    mStateChangeSeek(15000)
  end

  def mStateActionEvadeExit
    mStateChangeSeek(15000)
  end
  
  def mStateActionRamExit
    mStateChangeEvade(3000)
  end

  def mStateActionPatrolExit
    mStateChangeSeek(15000)
  end

  def mStateActionSeekExit
    if @r_piece.mWeapon.mAmmoCount == 0
      mStateChangeRam(60000)
    else
      mStateChangeEvade(3000)
    end
  end

  def mStateActionWaypointExit
    mStateChangeSeek(15000)
  end

end
