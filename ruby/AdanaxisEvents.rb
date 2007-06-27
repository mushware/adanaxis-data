#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisEvents.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 7+U6dcoMRIA9Kk+44ydQ6Q
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
