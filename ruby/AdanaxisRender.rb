#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisRender.rb
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
#%Header } gALWTcpqRL4PXzPDNgzRcg
# $Id: AdanaxisRender.rb,v 1.6 2006/11/09 23:53:59 southa Exp $
# $Log: AdanaxisRender.rb,v $
# Revision 1.6  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.5  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.4  2006/08/01 17:21:18  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:12  southa
# Pre-release updates
#

require 'Mushware.rb'

class AdanaxisRender < MushObject
  def initialize
    @m_packageID = MushGame.cPackageID
  end
 
  def mCreate
    @m_menuFont = MushGLFont.new(:name => 'library-font1');
    @m_menuStr = "Menu from ruby";
  end
    
  def mRenderMenu
    @m_menuFont.mRender(@m_menuStr)
  end
  
  def mRender
    mRenderMenu
  end

  def mPrecacheRender(inPercentage, inMB)
    @m_menuFont.colour = MushVector.new(1,1,1,0.3)
    @m_menuFont.mRenderAtSize("Loading... #{inPercentage}%", -0.4, -0.25, 0.02);
    @m_menuFont.colour = MushVector.new(1,1,1,0.1)
    @m_menuFont.mRenderAtSize("#{inMB}MB", -0.4, -0.27, 0.015);
  end

  def mPackageIDRender
    @m_menuFont.colour = MushVector.new(1,1,1,0.3)
    @m_menuFont.mRenderAtSize(@m_packageID, -@m_packageID.length * 0.006, -0.27, 0.012);
  end
end
