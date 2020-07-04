#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushTimedValue.rb
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
#%Header } 1Ha0j7N0BKznyCXX0AwJAA
# $Id: MushTimedValue.rb,v 1.2 2007/03/13 21:45:03 southa Exp $
# $Log: MushTimedValue.rb,v $
# Revision 1.2  2007/03/13 21:45:03  southa
# Release process
#
# Revision 1.1  2006/11/01 10:07:12  southa
# Shield handling
#

require 'MushGame.rb'

class MushTimedValue
  def initialize(inValue = 0)
    @m_value = inValue
    @m_lastValue = 0
    @m_lastChangeMsec = 0
  end
  
  def mValue
    @m_value
  end
  
  def mValueSet(inValue)
    @m_value = inValue
    @m_lastChangeMsec = MushGame.cGameMsec
  end
  
  def mCompareAndSet(inValue)
    mValueSet(inValue) if @m_value != inValue
  end
  
  def mGameMsecSinceChange
    retVal = MushGame.cGameMsec - @m_lastChangeMsec
    @m_lastChangeMsec = MushGame.cGameMsec if retVal < 0
    retVal
  end
end
