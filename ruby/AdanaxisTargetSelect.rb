#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisTargetSelect.rb
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
#%Header } VUmMueeDD/EDdtMNPpq2Wg
# $Id: AdanaxisTargetSelect.rb,v 1.4 2007/04/18 09:21:54 southa Exp $
# $Log: AdanaxisTargetSelect.rb,v $
# Revision 1.4  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.3  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.2  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.1  2006/10/02 20:28:09  southa
# Object lookup and target selection
#

require 'Mushware.rb'

class AdanaxisTargetSelect < MushObject
  def self.cSelect(inPost, inTypes, inExcludeID)
    targetID = nil
    inTypes.each do |type|
      targetID = MushGame.cTargetPieceSelect(inPost, type, inExcludeID)
      break if targetID
    end
    targetID
  end
end
