#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisScanner.rb
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
#%Header } 8i/YSBWq4JFkCOhfz2XfDQ
#
# $Id: AdanaxisScanner.rb,v 1.4 2007/04/20 12:07:08 southa Exp $
# $Log: AdanaxisScanner.rb,v $
# Revision 1.4  2007/04/20 12:07:08  southa
# Khazi Warehouse and level 8
#
# Revision 1.3  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.2  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.1  2007/03/13 12:22:50  southa
# Scanner symbols
#
#

require 'Mushware.rb'

class AdanaxisScanner < MushObject
  SYMBOL_KHAZI_PLAIN = 8
  SYMBOL_KHAZI_RED = 0
  SYMBOL_KHAZI_BLUE = 1
  SYMBOL_POWERKHAZI_RED = 2
  SYMBOL_POWERKHAZI_BLUE = 3
  SYMBOL_PRIMARYKHAZI_RED = 4
  SYMBOL_PRIMARYKHAZI_BLUE = 5
  SYMBOL_CARRIERKHAZI_RED = 6
  SYMBOL_CARRIERKHAZI_BLUE = 7
end
