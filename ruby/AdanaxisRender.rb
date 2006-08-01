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
# $Id: AdanaxisRender.rb,v 1.3 2006/08/01 13:41:12 southa Exp $
# $Log: AdanaxisRender.rb,v $
# Revision 1.3  2006/08/01 13:41:12  southa
# Pre-release updates
#

require 'Mushware.rb'

class AdanaxisRender < MushObject
  def initialize
    @packageID = MushGame.cPackageID
  end
 
  def mCreate
    @menuFont = MushGLFont.new(:name => 'library-font1');
    @menuStr = "Menu from ruby";
  end
    
  def mRenderMenu
    @menuFont.mRender(@menuStr)
  end
  
  def mRender
    mRenderMenu
  end

  def mPreCacheRender(percentage)
    @menuFont.colour = MushVector.new(1,1,1,0.3)
    @menuFont.mRenderAtSize("Loading... #{percentage}%", -0.4, -0.25, 0.02);
  end

  def mPackageIDRender
    @menuFont.colour = MushVector.new(1,1,1,0.3)
    @menuFont.mRenderAtSize(@packageID, -@packageID.length * 0.006, -0.27, 0.012);
  end

end
