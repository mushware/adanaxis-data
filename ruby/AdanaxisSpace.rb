#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisSpace.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.3, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } U1S8GssKDgFSsNiwIrKzyw
# $Id: AdanaxisSpace.rb,v 1.33 2007/05/24 16:59:42 southa Exp $
# $Log: AdanaxisSpace.rb,v $
# Revision 1.33  2007/05/24 16:59:42  southa
# Level 19
#
# Revision 1.32  2007/05/12 14:20:47  southa
# Level 16
#
# Revision 1.31  2007/05/10 14:06:25  southa
# Level 16 and retina spin
#
# Revision 1.30  2007/04/21 09:41:06  southa
# Level work
#
# Revision 1.29  2007/04/18 12:44:36  southa
# Cache purge fix and pre-release tweaks
#
# Revision 1.28  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.27  2007/03/24 18:07:23  southa
# Level 3 work
#
# Revision 1.26  2007/03/23 12:27:34  southa
# Added levels and Cistern mesh
#
# Revision 1.25  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.24  2007/03/09 11:29:12  southa
# Game end actions
#
# Revision 1.23  2007/03/08 18:38:14  southa
# Level progression
#
# Revision 1.22  2007/03/07 16:59:43  southa
# Khazi spawning and level ends
#
# Revision 1.21  2007/03/06 11:34:01  southa
# Space and precache fixes
#
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

  PRIMARY_NONE=0
  PRIMARY_RED=1
  PRIMARY_BLUE=2
  
  def initialize(inParams = {})
    @m_gameInited = false
    @m_spawnList = []
    @m_triggeredEvents = []
    @m_textureLibrary = AdanaxisTextureLibrary.new
    @m_materialLibrary = AdanaxisMaterialLibrary.new(:texture_library => @m_textureLibrary)
    @m_meshLibrary = AdanaxisMeshLibrary.new(:texture_library => @m_textureLibrary)
    @m_fontLibrary = AdanaxisFontLibrary.new(:texture_library => @m_textureLibrary)
    @m_waveLibrary = AdanaxisWaveLibrary.new
    @m_weaponLibrary = AdanaxisWeaponLibrary.new
    @m_pieceLibrary = AdanaxisPieceLibrary.new
    
    @m_khaziCount = 0;
    @m_khaziRedCount = 0;
    @m_khaziBlueCount = 0;
    @m_isBattle = false;
    # If primary is set, the level is complete when all primary targets are destroyed
    @m_primary = PRIMARY_NONE;
    @m_retinaSpin = 0.0;
    @m_jamming = false;
    
    @m_textFont = MushGLFont.new(:name => (inParams[:font] || 'library-font1'));
    @m_precacheIndex = 0
    
    @m_precacheList = nil
    
  end
  
  mush_reader :m_textureLibrary, :m_materialLibrary, :m_meshLibrary,
              :m_weaponLibrary, :m_fontLibrary, :m_pieceLibrary
              
  mush_accessor :m_khaziCount, :m_khaziRedCount, :m_khaziBlueCount, :m_isBattle, :m_primary, :m_retinaSpin, :m_jamming
  
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
  
  def mMusicAdd(inID, inName)
      MushGame.cSoundStreamDefine(inID, MushConfig.cGlobalWavesPath+'/'+inName)
  end
  
  def mPrecacheListAdd(inNames)
    @m_precacheList = [] unless @m_precacheList
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
  
  def mSpawn
    eventFound = false
    
    @m_triggeredEvents.reject! do |entry|
      deleteThis = false
      if !eventFound && entry.mKhaziTest == :zero_red
        send entry.mEvent
        eventFound = true
        deleteThis = true
      end
      deleteThis
    end
  end
  
  def mSpawnAdd(inSpawner)
    @m_triggeredEvents << AdanaxisTriggeredEvent.new(
      :khazi_test => :zero_red,
      :event => inSpawner
    )
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
  
  def mGameState
    retVal = MushGame::GAMERESULT_NONE
    if mIsBattle
      if mKhaziBlueCount == 0
        retVal = MushGame::GAMERESULT_LOST
      elsif mKhaziRedCount == 0
        unless mSpawn
          retVal = MushGame::GAMERESULT_WON
        end
      end
    else
      if mKhaziRedCount == 0
        unless mSpawn
          retVal = MushGame::GAMERESULT_WON
        end
      end
    end
    retVal
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
  
  def mCutSceneRender
  end
  
  def mEpilogueRender
  end
  
  def mTimeoutSpawnAdd(inSpawner, inTime)
    @m_triggeredEvents << AdanaxisTriggeredEvent.new(
      :game_msec => inTime,
      :khazi_test => :zero_red,
      :event => inSpawner
    )
  end

  def mTimeOnlySpawnAdd(inSpawner, inTime)
    @m_triggeredEvents << AdanaxisTriggeredEvent.new(
      :game_msec => inTime,
      :khazi_test => :none,
      :event => inSpawner
    )
  end

  def mGameModeTick

    gameMsec = MushGame.cGameMsec
    
    @m_triggeredEvents.reject! do |entry|
      deleteThis = false
      if entry.mGameMsec && entry.mGameMsec < gameMsec
        send entry.mEvent
        deleteThis = true
      end
      deleteThis
    end

  end
  
  def mJammersEliminated
  end
end
