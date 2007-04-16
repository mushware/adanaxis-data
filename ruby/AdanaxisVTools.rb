#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisVTools.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.2, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } GClYIpWC1wiDKDZ25rvXXg
#
# $Id: AdanaxisVTools.rb,v 1.2 2007/03/20 17:31:23 southa Exp $
# $Log: AdanaxisVTools.rb,v $
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
