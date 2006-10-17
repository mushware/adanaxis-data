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
# $Id: AdanaxisDashboard.rb,v 1.1 2006/10/17 15:27:59 southa Exp $
# $Log: AdanaxisDashboard.rb,v $
# Revision 1.1  2006/10/17 15:27:59  southa
# Player collisions
#

class AdanaxisDashboard < MushDashboard
  def initialize(inParams = {})
    @m_textFont = MushGLFont.new(:name => (inParams[:font] || 'library-font1'));
    @m_dashboardFont = MushGLFont.new(:name => (inParams[:dashboard_font] || 'dashboard1-font'));
    @m_hitPointRatio = 1.0
    @m_lastHitPointRatio = 1.0
    @m_lastHitMsec = 0
  end

  def mUpdate(inParams = {})
    @m_hitPointRatio = inParams[:hit_point_ratio] if inParams[:hit_point_ratio]
    if @m_hitPointRatio != @m_lastHitPointRatio
      @m_lastHitMsec = MushGame.cGameMsec
      @m_lastHitPointRatio = @m_hitPointRatio
    end
  end
  
  def mRender(inParams = {})
    timeNow = MushGame.cGameMsec
    hitAlpha = 1.0 - (timeNow - @m_lastHitMsec) / 1000.0
    hitAlpha = 0.3 if hitAlpha < 0.3
  
    points = Integer(@m_hitPointRatio * 100) 
    points = 0 if points < 0
    @m_dashboardFont.colour = case points
      when 0..20 : MushVector.new(1,0,0,hitAlpha)
      when 20..50 :  MushVector.new(1,1,0.5,hitAlpha)
      when 50..100 :  MushVector.new(0.3,0.6,1,hitAlpha)
      else MushVector.new(1,1,1,hitAlpha)
    end
    

    
    @m_dashboardFont.mRenderSymbolAtSize(0, -0.47, -0.28, 0.06);

    @m_dashboardFont.colour = MushVector.new(1,1,0.5,0.3)
    @m_dashboardFont.mRenderSymbolAtSize(1, -0.41, -0.28, 0.06);
  
    @m_textFont.colour = MushVector.new(1,1,1,hitAlpha)
    
    pointsStr = "#{points}"
    @m_textFont.mRenderAtSize(pointsStr, -0.47 - 0.01 * pointsStr.length, -0.28, 0.02);
  end
end
