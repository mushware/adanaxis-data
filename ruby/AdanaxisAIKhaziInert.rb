#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIKhaziInert.rb
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
#%Header } qHOkREnWoydKaX7tYWgG9g
#
# $Id: AdanaxisAIKhaziInert.rb,v 1.1 2007/04/20 12:07:07 southa Exp $
# $Log: AdanaxisAIKhaziInert.rb,v $
# Revision 1.1  2007/04/20 12:07:07  southa
# Khazi Warehouse and level 8
#
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'

class AdanaxisAIKhaziInert < AdanaxisAIKhazi

  def mStateActionIdle
    mStateChangeDormant(10000)
  end

  def mStateActionEvadeExit
    mStateChangeDormant(10000)
  end
  
  def mStateActionRamExit
    mStateChangeDormant(10000)
  end

  def mStateActionPatrolExit
    mStateChangeDormant(10000)
  end

  def mStateActionSeekExit
    mStateChangeDormant(10000)
  end

  def mStateActionWaypointExit
    mStateChangeDormant(10000)
  end

end
