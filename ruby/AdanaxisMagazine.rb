#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisMagazine.rb
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
#%Header } +tmxP7QtNEaGxcz28k74Gw
# $Id: AdanaxisMagazine.rb,v 1.7 2007/06/27 12:58:11 southa Exp $
# $Log: AdanaxisMagazine.rb,v $
# Revision 1.7  2007/06/27 12:58:11  southa
# Debian packaging
#
# Revision 1.6  2007/06/14 18:55:10  southa
# Level and display tweaks
#
# Revision 1.5  2007/06/14 12:14:14  southa
# Level 30
#
# Revision 1.4  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.3  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.2  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.1  2006/11/17 20:08:34  southa
# Weapon change and ammo handling
#

class AdanaxisMagazine < MushObject

  def initialize(inParams = {})
    @m_count = {}
    @m_count[:player_base] = 100
    @m_count[:player_light_cannon] = 0
    @m_count[:player_flak] = 0
    @m_count[:player_quad_cannon] = 0
    @m_count[:player_rail] = 0
    @m_count[:player_heavy_cannon] = 0
    @m_count[:player_light_missile] = 0
    @m_count[:player_heavy_missile] = 0
    @m_count[:player_flush] = 0
    @m_count[:player_nuclear] = 0
    @m_limit = {}
    @m_limit[:player_base] = 800
    @m_limit[:player_light_cannon] = 200
    @m_limit[:player_flak] = 100
    @m_limit[:player_quad_cannon] = 800
    @m_limit[:player_rail] = 100
    @m_limit[:player_heavy_cannon] = 800
    @m_limit[:player_light_missile] = 50
    @m_limit[:player_heavy_missile] = 50
    @m_limit[:player_flush] = 3
    @m_limit[:player_nuclear] = 1

    @m_warningShown = false
  end

  def mPlayerLoadAll
    @m_count[:player_base] = 800
    @m_count[:player_light_cannon] = 200
    @m_count[:player_flak] = 50
    @m_count[:player_quad_cannon] = 800
    @m_count[:player_rail] = 30
    @m_count[:player_heavy_cannon] = 200
    @m_count[:player_light_missile] = 30
    @m_count[:player_heavy_missile] = 10
    @m_count[:player_flush] = 3
    @m_count[:player_nuclear] = 1
  end

  def mAmmoAvailable(inType)
    return @m_count[inType] > 0
  end

  def mAmmoDecrement(inType)
    @m_count[inType] -= 1
    nil
  end

  def mAmmoCount(inType)
    @m_count[inType]
  end

  def mLimitedAmmoAdd(inType, inNumber)
    @m_count[inType] += inNumber
    @m_count[inType] = @m_limit[inType] if @m_count[inType] > @m_limit[inType]

    if inType == :player_nuclear && !@m_warningShown
      @m_warningShown = true
      MushGame.cNamedDialoguesAdd('^nuclear')
    end
  end
end
