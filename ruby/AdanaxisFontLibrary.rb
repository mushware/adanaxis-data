#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisFontLibrary.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } S4su0J0hNauRx9jalcH0rA
# $Id: AdanaxisFontLibrary.rb,v 1.15 2007/04/18 09:21:52 southa Exp $
# $Log: AdanaxisFontLibrary.rb,v $
# Revision 1.15  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.14  2007/04/16 18:50:57  southa
# Voice work
#
# Revision 1.13  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.12  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.11  2007/03/08 21:51:01  southa
# Count display
#
# Revision 1.10  2006/11/23 14:40:28  southa
# Intro cutscene
#
# Revision 1.9  2006/11/21 16:13:54  southa
# Cutscene handling
#
# Revision 1.8  2006/11/17 20:08:34  southa
# Weapon change and ammo handling
#
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
  DASHBOARD_RED_COUNT = 2
  DASHBOARD_BLUE_COUNT = 3

  SYMBOL_SCAN_WHITE = 8
  SYMBOL_SCAN_RED = 9
  SYMBOL_SCAN_GREEN = 10
  SYMBOL_SCAN_X = 16
  SYMBOL_SCAN_Y = 17
  SYMBOL_SCAN_Z = 18
  SYMBOL_SCAN_W = 19

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
      
    # Control tutorial fonts
    %w{ mouse1 mouseleftpressed1 mouserightpressed1 spacebar1 spacebarpressed1
        cross1 tick1 }.each do |name|
      MushGLTexture::cDefine(
		    :name          => "#{name}-font-tex",
        :type          => 'TIFF',
		    :filename      => MushConfig.cGlobalPixelsPath+"/#{name}.tiff",
		    :cache         => 0
	    )
      
      if name =~ /^space/
        extent = [512.0, 256.0]
        fontSize = [2, 1]
      else
        extent = [256.0, 256.0]
        fontSize = 1
      end
      
      MushGLFont.new(
        :name => "#{name}-font",
        :texture_name => "#{name}-font-tex",
        :divide => [1,1],
        :extent => extent,
        :size => fontSize
      )
    end
      
    end
  end
end
