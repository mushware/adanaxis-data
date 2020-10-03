#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisRender.rb
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
#%Header } sylbvJ6IW+uIKJSdRWD6fQ
# $Id: AdanaxisRender.rb,v 1.11 2007/06/27 12:58:12 southa Exp $
# $Log: AdanaxisRender.rb,v $
# Revision 1.11  2007/06/27 12:58:12  southa
# Debian packaging
#
# Revision 1.10  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.9  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.8  2007/03/13 21:45:08  southa
# Release process
#
# Revision 1.7  2007/02/08 17:55:12  southa
# Common routines in space generation
#
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
    @m_menuFont.mRenderAtSize(@m_packageID, -@m_packageID.length * 0.006, -0.47, 0.012);
  end
end
