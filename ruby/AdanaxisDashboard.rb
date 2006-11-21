#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisDashboard.rb
#
# Copyright Andy Southgate 2006
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
#%Header } jlpar81vJMXtlQaf/66fpw
# $Id: AdanaxisDashboard.rb,v 1.5 2006/11/17 20:08:34 southa Exp $
# $Log: AdanaxisDashboard.rb,v $
# Revision 1.5  2006/11/17 20:08:34  southa
# Weapon change and ammo handling
#
# Revision 1.4  2006/11/01 13:04:20  southa
# Initial weapon handling
#
# Revision 1.3  2006/11/01 10:07:12  southa
# Shield handling
#
# Revision 1.2  2006/10/17 20:43:00  southa
# Dashboard work
#
# Revision 1.1  2006/10/17 15:27:59  southa
# Player collisions
#

class AdanaxisDashboard < MushDashboard
  @@c_weaponFonts = {
    :player_base => 'basebox1-font',
    :player_light_cannon => 'lightcannonbox1-font',
    :player_flak => 'flakbox1-font',
    :player_quad_cannon => 'quadcannonbox1-font',
    :player_rail => 'railbox1-font',
    :player_heavy_cannon => 'heavycannonbox1-font',
    :player_light_missile => 'lightmissilebox1-font',
    :player_heavy_missile => 'heavymissilebox1-font',
    :player_flush => 'flushbox1-font',
    :player_nuclear => 'nuclearbox1-font'
  }

  def initialize(inParams = {})
    @m_textFont = MushGLFont.new(:name => (inParams[:font] || 'library-font1'));
    @m_dashboardFont = MushGLFont.new(:name => (inParams[:dashboard_font] || 'dashboard1-font'));
    @m_hitPointRatio = MushTimedValue.new(1.0)
    @m_shieldRatio = MushTimedValue.new(1.0)
    @m_ammoCount = MushTimedValue.new(0)
    @m_weaponFont = MushGLFont.new(:name => "basebox1-font")
    @m_valueSize = 0.06
  end

  def mUpdate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_hitPointRatio.mCompareAndSet(inParams[:hit_point_ratio]) if inParams[:hit_point_ratio]
    @m_shieldRatio.mCompareAndSet(inParams[:shield_ratio]) if inParams[:shield_ratio]
    @m_ammoCount.mCompareAndSet(inParams[:ammo_count]) if inParams[:ammo_count]
    fontName = inParams[:weapon_name]
    if fontName
      @m_weaponFont = MushGLFont.new(:name => @@c_weaponFonts[fontName])
    end
  end

  def mRenderValuesBeginLeft
    @m_valueXPos = -0.5
    @m_valueXStep = 1.0
    @m_valueYPos = -0.28
  end
  
  def mRenderValuesBeginRight
    @m_valueXPos = 0.5
    @m_valueXStep = -1.0
    @m_valueYPos = -0.28
  end
  
  def mRenderValueNext
    @m_valueXPos += @m_valueXStep * @m_valueSize
  end
  
  def mRenderValue(inSymbol, inValue, inColour, inFont = @m_dashboardFont)
    xCentre = @m_valueXPos + @m_valueXStep * @m_valueSize / 2.0
  
    inFont.colour = inColour
    inFont.mRenderSymbolAtSize(inSymbol, xCentre, @m_valueYPos, @m_valueSize);
  
    @m_textFont.colour = MushVector.new(1,1,1,inColour.w)
    
    valueStr = inValue.to_s
    xTextCentre = xCentre - 0.01 * valueStr.length
    @m_textFont.mRenderAtSize(valueStr, xTextCentre, @m_valueYPos, @m_valueSize / 3.0);
    
    mRenderValueNext
  end
  
  def mAlphaForValue(inTimedValue)
    alpha = 1.0 - (inTimedValue.mGameMsecSinceChange) / 1000.0
    alpha = 0.3 if alpha < 0.3
    return alpha
  end
  
  def mRender(inParams = {})
    mRenderValuesBeginLeft

    alpha = mAlphaForValue(@m_hitPointRatio)
    value = Integer(@m_hitPointRatio.mValue * 100) 
    value = 0 if value < 0
    colour = case value
      when 0..20 : MushVector.new(1,0,0,alpha)
      when 20..50 :  MushVector.new(1,1,0.5,alpha)
      when 50..100 :  MushVector.new(0.3,0.6,1,alpha)
      else MushVector.new(1,1,1,alpha)
    end
    
    mRenderValue(AdanaxisFontLibrary::DASHBOARD_HEALTH, value, colour)
    
    alpha = mAlphaForValue(@m_shieldRatio)
    value = Integer(@m_shieldRatio.mValue * 100) 
    value = 0 if value < 0
    colour = case value
      when 0 : MushVector.new(0.3,0.3,0.3,alpha)
      when 1..100 :  MushVector.new(1.0,1.0,0.5,alpha)
      else MushVector.new(0.6,0.8,1,[alpha, 0.4].max)
    end

    mRenderValue(AdanaxisFontLibrary::DASHBOARD_SHIELD, value, colour)
    
    mRenderValuesBeginRight
    
    alpha = mAlphaForValue(@m_ammoCount)
    value = Integer(@m_ammoCount.mValue) 
    value = 0 if value < 0
    colour = case value
      when 0 : MushVector.new(0.3,0.3,0.3,alpha)
      else MushVector.new(1,1,1,alpha)
    end

    mRenderValue(0, value, colour, @m_weaponFont)    
  end
end
