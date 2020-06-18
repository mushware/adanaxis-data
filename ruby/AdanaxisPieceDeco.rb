#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisPieceDeco.rb
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
#%Header } Y+2+6aIGEU+w6wUfSLsJzw
# $Id: AdanaxisPieceDeco.rb,v 1.9 2007/04/18 09:21:53 southa Exp $
# $Log: AdanaxisPieceDeco.rb,v $
# Revision 1.9  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.8  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.7  2007/03/13 21:45:08  southa
# Release process
#
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
