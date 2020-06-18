#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisVTools.rb
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
#%Header } E4NNZx9PQkXA/TQ9cx5b5g
#
# $Id: AdanaxisVTools.rb,v 1.4 2007/04/18 09:21:54 southa Exp $
# $Log: AdanaxisVTools.rb,v $
# Revision 1.4  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.3  2007/04/16 08:41:07  southa
# Level and header mods
#
# Revision 1.2  2007/03/20 17:31:23  southa
# Difficulty and GL options
#
# Revision 1.1  2007/03/19 16:01:35  southa
# Damage indicators
#

require 'Mushware.rb'

class AdanaxisVTools < MushObject
  # Determine what damage icons to show when the player is hit
  def self.cApproachVectorToDamageIcons(inVel)
    mag = inVel.mMagnitude
    maxDisp = [inVel.x.abs, inVel.y.abs, inVel.z.abs].max   
    if mag <= 0.0 || (maxDisp < mag * 0.25 && inVel.w > 0)
       # Either small displacement and in front, or no velocity - light all icons
      retArray = Array.new(6, 1.0)
    else
      retArray = Array.new(6, 0.0)
      retArray[0] = 1.0 if inVel.x >= 0.0 && inVel.x.abs*2 > maxDisp
      retArray[1] = 1.0 if inVel.x <= 0.0 && inVel.x.abs*2 > maxDisp
      retArray[2] = 1.0 if inVel.y >= 0.0 && inVel.y.abs*2 > maxDisp
      retArray[3] = 1.0 if inVel.y <= 0.0 && inVel.y.abs*2 > maxDisp
      retArray[4] = 1.0 if inVel.z >= 0.0 && inVel.z.abs*2 > maxDisp
      retArray[5] = 1.0 if inVel.z <= 0.0 && inVel.z.abs*2 > maxDisp
    end
    retArray
  end
end
