#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceDeco.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } 0E8SSmL7Q12OXGc5q+oEMw
# $Id: AdanaxisPieceDeco.rb,v 1.6 2006/10/30 19:36:38 southa Exp $
# $Log: AdanaxisPieceDeco.rb,v $
# Revision 1.6  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.5  2006/10/30 17:03:49  southa
# Remnants creation
#
# Revision 1.4  2006/10/19 15:41:34  southa
# Item handling
#
# Revision 1.3  2006/10/16 14:36:50  southa
# Deco handling
#
# Revision 1.2  2006/10/15 17:12:53  southa
# Scripted explosions
#
# Revision 1.1  2006/10/14 16:59:43  southa
# Ruby Deco objects
#

class AdanaxisPieceDeco < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "d"
    super
    @m_lifeMsec = inParams[:lifetime_msec] || 0
  end
end
