#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisSpace.rb
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
#%Header } lR/lFdEFyXBbk1T1wsvmCw
# $Id: AdanaxisSpace.rb,v 1.17 2006/11/17 20:08:34 southa Exp $
# $Log: AdanaxisSpace.rb,v $
# Revision 1.17  2006/11/17 20:08:34  southa
# Weapon change and ammo handling
#
# Revision 1.16  2006/11/17 15:47:42  southa
# Ammo remnants
#
# Revision 1.15  2006/11/15 18:25:54  southa
# Khazi rails
#
# Revision 1.14  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.13  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.12  2006/11/01 13:04:21  southa
# Initial weapon handling
#
# Revision 1.11  2006/10/18 13:22:08  southa
# World rendering
#
# Revision 1.10  2006/10/06 14:48:17  southa
# Material animation
#
# Revision 1.9  2006/09/07 10:02:36  southa
# Shader interface
#
# Revision 1.8  2006/08/01 17:21:18  southa
# River demo
#
# Revision 1.7  2006/08/01 13:41:12  southa
# Pre-release updates
#

class AdanaxisSpace < MushObject
  def initialize(inParams = {})
    @m_gameInited = false
    @m_textureLibrary = AdanaxisTextureLibrary.new
    @m_materialLibrary = AdanaxisMaterialLibrary.new(:texture_library => @m_textureLibrary)
    @m_meshLibrary = AdanaxisMeshLibrary.new(:texture_library => @m_textureLibrary)
    @m_fontLibrary = AdanaxisFontLibrary.new(:texture_library => @m_textureLibrary)
    @m_waveLibrary = AdanaxisWaveLibrary.new
    @m_weaponLibrary = AdanaxisWeaponLibrary.new
  end
  
  mush_reader :m_textureLibrary, :m_materialLibrary, :m_meshLibrary, :m_weaponLibrary, :m_fontLibrary
  
  def mLoadStandard(game)
    @m_fontLibrary.mCreate
    @m_textureLibrary.mCreate
	  @m_materialLibrary.mCreate
	  @m_meshLibrary.mCreate
    AdanaxisShaderLibrary.cCreate
	  @m_waveLibrary.mCreate
	  @m_weaponLibrary.mCreate
    
    dialogueFile = game.mSpacePath+"/dialogues.xml"
    if File.file?(dialogueFile)
      MushGame.cGameDialoguesLoad(dialogueFile)
    end
  end
  
  def mStandardPrecache(inNum)
    if inNum < @m_textureLibrary.mExploNames.size
      @m_textureLibrary.mExploNames[inNum].each do |texName|
        MushGLTexture.cPreCache(texName) unless $MUSHCONFIG['-DEBUG']
      end
    end
    
    if inNum == @m_textureLibrary.mExploNames.size # Yep, mExploNames
      @m_textureLibrary.mCosmos1Names.each do |texName|
        MushGLTexture.cPreCache(texName)
      end
    end
  end
  
  def mPreCache
    # Stop precaching by returning 100%
    100
  end
  
  def mGameInit
    MushGame.cNamedDialoguesAdd('^start')
  end
  
  def mHandlePreCacheEnd
    mGameInit unless @m_gameInited
    @m_gameInited = true
  end
  
  def mInitialPiecesCreate
  end
  
  def mIsMenuBackdrop
    false
  end  
end
