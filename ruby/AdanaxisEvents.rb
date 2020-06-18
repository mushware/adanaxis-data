#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisEvents.rb
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
#%Header } OQFCj7GslchlElvqeNNnGQ
# $Id: AdanaxisEvents.rb,v 1.10 2007/06/27 12:58:10 southa Exp $
# $Log: AdanaxisEvents.rb,v $
# Revision 1.10  2007/06/27 12:58:10  southa
# Debian packaging
#
# Revision 1.9  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.8  2007/03/24 18:07:22  southa
# Level 3 work
#
# Revision 1.7  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.6  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.5  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.4  2006/11/02 09:47:32  southa
# Player weapon control
#
# Revision 1.3  2006/10/09 16:00:15  southa
# Intern generation
#
# Revision 1.2  2006/08/25 01:44:56  southa
# Khazi fire
#
# Revision 1.1  2006/08/24 13:04:37  southa
# Event handling
#

class AdanaxisEventFire < MushEvent
  def initialize
    @m_post = MushPost.new
    @m_targetID = ""
  end

  mush_accessor :m_post, :m_targetID
end

class AdanaxisEventKeyState < MushEvent
  def initialize
    @m_keyNum = []
    @m_state = []
  end

  mush_accessor :m_keyNum, :m_state
end

class AdanaxisEventSpaceCall < MushEvent
  def initialize
    @m_method = nil
  end

  mush_accessor :m_method
end
