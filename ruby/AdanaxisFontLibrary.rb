#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisFontLibrary.rb
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
#%Header } ZGY5KHoT9+kVQm3zBeLowg
# $Id: AdanaxisFontLibrary.rb,v 1.7 2006/11/01 13:04:20 southa Exp $
# $Log: AdanaxisFontLibrary.rb,v $
# Revision 1.7  2006/11/01 13:04:20  southa
# Initial weapon handling
#
# Revision 1.6  2006/10/17 20:43:00  southa
# Dashboard work
#
# Revision 1.5  2006/08/01 17:21:17  southa
# River demo
#
# Revision 1.4  2006/08/01 13:41:11  southa
# Pre-release updates
#

class AdanaxisFontLibrary < MushObject
  DASHBOARD_HEALTH = 0
  DASHBOARD_SHIELD = 1

  def initialize(inParams = {})
    @m_textureLibrary = inParams[:texture_library] || raise("No texture library supplied to font library")
  end

  def mCreate
  	MushGLTexture::cDefine(
		  :name          => 'library-font1-tex',
      :type          => 'TIFF',
      :filename      => MushConfig.cGlobalPixelsPath+'/font-mono1.tiff',
		  :cache         => 0
	  )
  
	  MushGLFont.new(
      :name => 'library-font1',
      :texture_name => 'library-font1-tex',
      :divide => [8,12],
      :extent => [337/8.0, 768/12.0],
      :size => 0.05
    )
    
    MushGLTexture::cDefine(
		  :name          => 'symbol1-font-tex',
      :type          => 'TIFF',
		  :filename      => MushConfig.cGlobalPixelsPath+'/symbol1.tiff',
		  :cache         => 0
	  )
    
    MushGLFont.new(
      :name => 'symbol1-font',
      :texture_name => 'symbol1-font-tex',
      :divide => [8,8],
      :extent => [512.0/8, 512.0/8],
      :size => 1
    )
    
    MushGLTexture::cDefine(
		  :name          => 'dashboard1-font-tex',
      :type          => 'TIFF',
		  :filename      => MushConfig.cGlobalPixelsPath+'/dashboard1.tiff',
		  :cache         => 0
	  )
    
    MushGLFont.new(
      :name => 'dashboard1-font',
      :texture_name => 'dashboard1-font-tex',
      :divide => [2,2],
      :extent => [256.0/2, 256.0/2],
      :size => 1
    )
    
    # Reuse object textures for font
    @m_textureLibrary.mBoxNames.each do |name|
      MushGLFont.new(
        :name => "#{name}box1-font",
        :texture_name => "#{name}box1-tex",
        :divide => [1,1],
        :extent => [256.0, 256.0],
        :size => 1
      )
    end
  end
end
