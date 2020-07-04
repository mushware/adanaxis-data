#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisScanner.rb
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
#%Header } qA9i9wlvIxajlUchA9Lepg
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
