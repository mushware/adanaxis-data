#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisTriggeredEvent.rb
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
#%Header } Fgs21ZSbcZ3APXBjBOrkdg
 #
 # $Id: AdanaxisTriggeredEvent.rb,v 1.2 2007/04/18 09:21:54 southa Exp $
 # $Log: AdanaxisTriggeredEvent.rb,v $
 # Revision 1.2  2007/04/18 09:21:54  southa
 # Header and level fixes
 #
 # Revision 1.1  2007/03/24 18:07:23  southa
 # Level 3 work
 #
 
class AdanaxisTriggeredEvent < MushObject

  def initialize(inParams = {})
    AdanaxisUtil::cSpellCheck(inParams)
    @m_gameMsec = inParams[:game_msec]
    @m_khaziTest = inParams[:khazi_test]
    @m_event = inParams[:event] || nil
  end
  
  mush_accessor :m_gameMsec, :m_khaziTest, :m_event
end
