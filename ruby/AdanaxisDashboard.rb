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
# $Id: AdanaxisDashboard.rb,v 1.3 2006/11/01 10:07:12 southa Exp $
# $Log: AdanaxisDashboard.rb,v $
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
  def initialize(inParams = {})
    @m_textFont = MushGLFont.new(:name => (inParams[:font] || 'library-font1'));
    @m_dashboardFont = MushGLFont.new(:name => (inParams[:dashboard_font] || 'dashboard1-font'));
    @m_hitPointRatio = MushTimedValue.new(1.0)
    @m_shieldRatio = MushTimedValue.new(1.0)
    
    @m_valueSize = 0.06
  end

  def mUpdate(inParams = {})
    @m_hitPointRatio.mCompareAndSet(inParams[:hit_point_ratio]) if inParams[:hit_point_ratio]
    @m_shieldRatio.mCompareAndSet(inParams[:shield_ratio]) if inParams[:shield_ratio]
  end
  
  def mRenderValuesBeginLeft
    @m_valueXPos = -0.5
    @m_valueXStep = 1.0
    @m_valueYPos = -0.28
  end
  
  def mRenderValueNext
    @m_valueXPos += @m_valueXStep * @m_valueSize
  end
  
  def mRenderValue(inSymbol, inValue, inColour)
    xCentre = @m_valueXPos + @m_valueSize / 2.0
  
    @m_dashboardFont.colour = inColour
    @m_dashboardFont.mRenderSymbolAtSize(inSymbol, xCentre, @m_valueYPos, @m_valueSize);
  
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
  end
end
