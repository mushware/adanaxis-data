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
# $Id: AdanaxisSpace.rb,v 1.20 2007/02/08 17:55:12 southa Exp $
# $Log: AdanaxisSpace.rb,v $
# Revision 1.20  2007/02/08 17:55:12  southa
# Common routines in space generation
#
# Revision 1.19  2006/12/16 10:57:21  southa
# Encrypted files
#
# Revision 1.18  2006/12/14 15:59:23  southa
# Fire and cutscene fixes
#
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
    @m_pieceLibrary = AdanaxisPieceLibrary.new
    @m_precacheIndex = 0
    
    @m_precacheList = nil
    
  end
  
  mush_reader :m_textureLibrary, :m_materialLibrary, :m_meshLibrary,
              :m_weaponLibrary, :m_fontLibrary, :m_pieceLibrary
  
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
  
  def mPrecacheListAdd(inNames)
    raise "Precache list not built yet" unless @m_precacheList
    if inNames === String
      @m_precacheList.unshift inNames
    else
      inNames.flatten.each do |name|
        @m_precacheList.unshift name
      end
    end
  end
  
  def mPrecacheListBuild
    @m_precacheList = []
    
    @m_textureLibrary.mExploNames.each do |exploSet|
      exploSet.each do |texName|
        @m_precacheList << texName
      end
    end

    @m_textureLibrary.mCosmos1Names.each do |texName|
      @m_precacheList << texName
    end
        
    10.times { |i| @m_precacheList << "ember#{i}-tex" }
    10.times { |i| @m_precacheList << "star#{i}-tex" }
    10.times { |i| @m_precacheList << "flare#{i}-tex" }
    @m_precacheList << "attendant-tex"
    @m_precacheList << "projectile1-tex"
    @m_precacheList << "projectile2-tex"
  end
  
  def mPrecache
    unless @m_precacheList
      mPrecacheListBuild
      @m_precacheList.unshift(nil, nil, nil) # Skip a few frames to show the loading screen
    else
      startTime = Time.now.to_f
      while @m_precacheIndex < @m_precacheList.size do
        i = @m_precacheIndex
        @m_precacheIndex += 1 # Always increment in case of throw
        break unless @m_precacheList[i] # If nil, skip this frame
        
        MushGLTexture.cPrecache(@m_precacheList[i])

        break if Time.now.to_f > startTime + 0.1 # Yield to draw a frame every 100ms
      end
    end

    return (100*@m_precacheIndex) / @m_precacheList.size
  end
  
  def mStandardCosmos(inSeed)
    srand(inSeed)
    
    1000.times do
      pos = MushTools.cRandomUnitVector * (7 + 20 * rand)
      world = AdanaxisWorld.new(
        :mesh_name => mMeshLibrary.mRandomCosmosName,
        :post => MushPost.new(
          :position => pos
        )
      )
    end
  end
  
  def mGameInit
    # @m_precachePercent = 0
    MushGame.cNamedDialoguesAdd('^start')
  end
  
  def mHandlePrecacheEnd
    mGameInit unless @m_gameInited
    @m_gameInited = true
  end
  
  def mInitialPiecesCreate
  end
  
  def mIsMenuBackdrop
    false
  end  
end
