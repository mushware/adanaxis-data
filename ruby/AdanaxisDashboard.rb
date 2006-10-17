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
# $Id$
# $Log$

class AdanaxisDashboard < MushDashboard
  def initialize(inParams = {})
    @m_font = MushGLFont.new(:name => (inParams[:font] || 'library-font1'));
    
    @m_hitPointRatio = 1.0
  end

  def mUpdate(inParams = {})
    @m_hitPointRatio = inParams[:hit_point_ratio] if inParams[:hit_point_ratio]
  end
  
  def mRender(inParams = {})
    points = Integer(@m_hitPointRatio * 100) 
  
    @m_font.colour = MushVector.new(1,1,1,0.3)
    @m_font.mRenderAtSize("#{points}", -0.45, -0.30, 0.02);
  end
end
