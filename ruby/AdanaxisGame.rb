#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisGame.rb
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
#%Header } UtX/EqKKiZO0+2vstKG42g
# $Id: AdanaxisGame.rb,v 1.51 2007/06/30 11:45:42 southa Exp $
# $Log: AdanaxisGame.rb,v $
# Revision 1.51  2007/06/30 11:45:42  southa
# X11 release
#
# Revision 1.50  2007/06/27 13:18:53  southa
# Debian packaging
#
# Revision 1.49  2007/06/27 12:58:10  southa
# Debian packaging
#
# Revision 1.48  2007/06/14 18:55:10  southa
# Level and display tweaks
#
# Revision 1.47  2007/06/02 15:56:56  southa
# Shader fix and prerelease work
#
# Revision 1.46  2007/05/09 19:24:43  southa
# Level 14
#
# Revision 1.45  2007/04/20 16:46:03  southa
# Key configuration fix
#
# Revision 1.44  2007/04/18 20:08:39  southa
# Tweaks and fixes
#
# Revision 1.43  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.42  2007/04/17 10:08:12  southa
# Voice work
#
# Revision 1.41  2007/04/16 18:50:57  southa
# Voice work
#
# Revision 1.40  2007/03/24 18:07:22  southa
# Level 3 work
#
# Revision 1.39  2007/03/20 17:31:23  southa
# Difficulty and GL options
#
# Revision 1.38  2007/03/19 16:01:34  southa
# Damage indicators
#
# Revision 1.37  2007/03/16 19:50:43  southa
# Damage indicators
#
# Revision 1.36  2007/03/12 21:05:59  southa
# Scanner symbols
#
# Revision 1.35  2007/03/09 19:50:10  southa
# Resident textures
#
# Revision 1.34  2007/03/09 11:29:12  southa
# Game end actions
#
# Revision 1.33  2007/03/08 18:38:13  southa
# Level progression
#
# Revision 1.32  2007/03/08 11:00:28  southa
# Level epilogue
#
# Revision 1.31  2007/03/07 16:59:42  southa
# Khazi spawning and level ends
#
# Revision 1.30  2007/02/08 17:55:12  southa
# Common routines in space generation
#
# Revision 1.29  2006/12/14 15:59:18  southa
# Fire and cutscene fixes
#
# Revision 1.28  2006/11/25 21:26:30  southa
# Display mode definitions
#
# Revision 1.27  2006/11/21 10:08:23  southa
# Initial cut scene handling
#
# Revision 1.26  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.25  2006/11/08 18:30:53  southa
# Key and axis configuration
#
# Revision 1.24  2006/11/06 19:27:51  southa
# Mushfile handling
#
# Revision 1.23  2006/11/06 12:56:31  southa
# MushFile work
#
# Revision 1.22  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.21  2006/10/12 22:04:46  southa
# Collision events
#
# Revision 1.20  2006/10/06 14:48:17  southa
# Material animation
#
# Revision 1.19  2006/08/01 17:21:17  southa
# River demo
#
# Revision 1.18  2006/08/01 13:41:11  southa
# Pre-release updates
#

require 'Mushware.rb'

require 'AdanaxisLevels.rb'

class AdanaxisGame < MushObject
  def initialize
    @m_spaceName = 'menu1'
    @m_levels = AdanaxisLevels.new

    @m_view = MushView.new(
      :dashboard => AdanaxisDashboard.new
    )

    @m_menuRender = AdanaxisRender.new
    @m_menuRender.mCreate

    @m_menuSet = AdanaxisMenu.new
    @m_currentMenu = 0
    @m_entryDisplayMode = ""
    @m_textureDetail = 0
    @m_showHidden = false;
  end

  mush_accessor :m_space, :m_spaceName, :m_view

  def mSpaceObjectName
    'Adanaxis_'+@m_spaceName
  end

  def mSpacePath
    MushConfig.cGlobalSpacesPath + '/' + @m_spaceName
  end

  def mMushLoad
    if File.directory?(MushConfig.cGlobalMushPath)
      Dir.foreach(MushConfig.cGlobalMushPath) do |leafname|
        filename = File.expand_path(leafname, MushConfig.cGlobalMushPath).untaint
        if File.file?(filename) && File.extname(filename) == '.mush'
          MushFile.cLibraryAdd(filename)
        end
      end
    end
    # MushFile.cLibraryDump
  end

  def mLoad
    mMushLoad
    raise "Level unavailable (no space.rb file)" unless File.file?(mSpacePath+'/space.rb')
    require(mSpacePath+'/space.rb')
    @m_space = eval("#{mSpaceObjectName}.new", binding, mSpacePath+'/space.rb', 1)
    @m_space.mLoad(self)
    mView.mDashboard.mUpdate(:is_battle => @m_space.mIsBattle, :primary => @m_space.mPrimary)
    self
  end

  def mRender(inParams = {})
    @m_view.mDashboardRender(inParams)
  end

  def mCutSceneRender(inNum)
    @m_space.mCutSceneRender(inNum)
  end

  def mEpilogueRender
    @m_space.mEpilogueRender
  end

  def mMenuRender(msec)
    menu = @m_menuSet.mMenu(@m_currentMenu)
    menu.highlight_colour = MushVector.new(1,1,0.7,0.5+0.25*Math.sin(msec/100.0))
    menu.mRender(msec)
    @m_menuRender.mPackageIDRender
  end

  def mPrecacheRender(inPercentage, inMB)
    @m_menuRender.mPrecacheRender(inPercentage, inMB)
  end

  def mGameModeTick
    @m_space.mGameModeTick if @m_space
  end

  def mJammersEliminated
    @m_space.mJammersEliminated if @m_space
  end

  def mReset(allowResume)
    @m_currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    @m_menuSet.mReset(@m_currentMenu)
    @m_menuSet.mAllowResumeSet(allowResume)
    @m_menuSet.mUpdate(@m_currentMenu)
  end

  def mEpilogueStartDead
    MushGame.cNamedDialoguesAdd('^dead')
  end

  def mEpilogueStartLost
    MushGame.cNamedDialoguesAdd('^lost')
  end

  def mEpilogueStartWon
    MushGame.cNamedDialoguesAdd('^won')
  end

  def mKhaziCountUpdate(inKhazi, inRedKhaziCount, inBlueKhaziCount, inRedKhaziTotal, inBlueKhaziTotal)
    mView.mDashboard.mUpdate(
      :red_count => inRedKhaziCount,
      :blue_count => inBlueKhaziCount,
      :red_total => inRedKhaziTotal,
      :blue_total => inBlueKhaziTotal
      )

    @m_space.mKhaziCountSet(inKhazi)
    @m_space.mKhaziRedCountSet(inRedKhaziCount)
    @m_space.mKhaziBlueCountSet(inBlueKhaziCount)

    return @m_space.mGameState
  end

  def mCutSceneKeypress(inKey, inModifier, inIsDown)
    if inKey == 32 && inIsDown
      MushGame.cCutSceneModeExit
    end
  end

  def mEpilogueKeypress(inKey, inModifier, inIsDown)
    if inIsDown
      case inKey
        when MushKeys::SDLK_SPACE, MushKeys::KEY_MOUSE0, MushKeys::SDLK_KP_ENTER, MushKeys::SDLK_RETURN
          if MushGame.cEpilogueRunMsec > 3000
            if MushGame.cEpilogueWon
              newSpaceName = @m_levels.mNextLevelKey(@m_spaceName)
              @m_spaceName = newSpaceName if newSpaceName
              MushGame.cNewGameEnter
            else
              # Keep current @m_spaceName
              MushGame.cNewGameEnter
            end
          end
        when MushKeys::SDLK_ESCAPE
          MushGame.cMenuModeEnter
      end
    end
  end

  def mKeypress(inKey, inModifier, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    # keyName = MushGame.cKeySymbolsToName(inKey);
    # puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"

    @m_showHidden = ((inModifier & (MushKeys::KMOD_LSHIFT | MushKeys::KMOD_RSHIFT)) != 0)

    if inIsDown
      menu = @m_menuSet.mMenu(@m_currentMenu)

      if (@m_menuSet.mAxisKeyWait || @m_menuSet.mKeyWait)
        inKey = 0 if inKey == 27
        menu.mKeypress(self, inKey)
      else
        case inKey
          when MushKeys::SDLK_ESCAPE
            if @m_currentMenu == AdanaxisMenu::MENU_TOPLEVEL
              MushGame.cGameModeEnter unless @m_spaceName =~ /^menu/
            else
              if @m_currentMenu == AdanaxisMenu::MENU_OPTIONS &&
                (@m_entryDisplayMode != MushGame.cDisplayModeString || @m_textureDetail != MushGame.cTextureDetail)
                MushGame.cDisplayReset
              end
              @m_currentMenu = AdanaxisMenu::MENU_TOPLEVEL
            end
          when MushKeys::SDLK_UP : menu.mUp
          when MushKeys::SDLK_DOWN : menu.mDown
          when MushKeys::SDLK_KP_ENTER, MushKeys::SDLK_RETURN: menu.mEnter(self)
          when MushKeys::SDLK_LEFT: menu.mLeft(self)
          when MushKeys::SDLK_RIGHT: menu.mRight(self)
        end
      end
      @m_menuSet.mUpdate(@m_currentMenu)
    end
  end

  def mMenuResume(param, input)
    MushGame.cGameModeEnter
  end

  def mMenuQuit(param, input)
    MushGame.cQuit
  end

  def mMenuQuitToHelp(param, input)
    begin
      MushGame.cHelpFileOpen
    rescue Exception => e
      puts "Exception: "+e
    end
    MushGame.cQuit
  end

  def mMenuBack(param, input)
    if (param)
      @m_currentMenu = param
    else
      @m_currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    end
  end

  def mToMenu(param, input)
    @m_currentMenu = param
    @m_menuSet.mReset(@m_currentMenu)

    case @m_currentMenu
      when AdanaxisMenu::MENU_CHOOSE_LEVEL:
        @m_levels.mScanForLevels
        @m_menuSet.mUpdateLevels(@m_levels.mLevelList, @m_showHidden)
    end
  end

  def mMenuAxisKey(param, input)
    @m_menuSet.mWaitForAxisKey(param)
  end

  def mMenuAxisKeyReceived(inKey, param)
    MushGame.cAxisKeySet(inKey, param)
    @m_menuSet.mWaitForAxisKey(nil)
  end

  def mMenuKey(param, input)
    @m_menuSet.mWaitForKey(param)
  end

  def mMenuKeyReceived(inKey, param)
    MushGame.cKeySet(inKey, param)
    @m_menuSet.mWaitForKey(nil)
  end

  def mMenuAxis(param, input)
    axis = AdanaxisControl.cNextAxis( MushGame.cAxisSymbol(param) )
    MushGame.cAxisSet(axis, param)
  end

  def mMenuUseJoystick(param, input)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_X, AdanaxisControl::AXIS_XW)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_Y, AdanaxisControl::AXIS_YW)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_Z, AdanaxisControl::AXIS_ZW)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_W, AdanaxisControl::AXIS_W)
    MushGame.cKeySet(MushKeys::KEYSTICK_0_0, AdanaxisControl::KEY_FIRE);
  end

  def mMenuControlsDefault(param, input)
    MushGame.cControlsToDefaultSet
    @m_currentMenu = AdanaxisMenu::MENU_TOPLEVEL
  end

  def mMenuGameSelect(params, input)
    @m_spaceName = params
    MushGame.cNewGameEnter
  end

  def mMenuToOptions(params, input)
    @m_entryDisplayMode = MushGame.cDisplayModeString
    @m_textureDetail = MushGame.cTextureDetail
    @m_currentMenu = AdanaxisMenu::MENU_OPTIONS
  end

  def mMenuDisplayMode(params, input)
    if (input < 0)
      MushGame.cPreviousDisplayMode
    else
      MushGame.cNextDisplayMode
    end
  end

  def mMenuDisplayReset(params, input)
    if @m_entryDisplayMode != MushGame.cDisplayModeString || @m_textureDetail != MushGame.cTextureDetail
      MushGame.cDisplayReset
    end

    if (params)
      @m_currentMenu = params
    else
      @m_currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    end
  end

  def mMenuDifficulty(params, input)
    if input < 0
      AdanaxisRuby.cConfigDifficultySet( (AdanaxisRuby.cConfigDifficulty + 2) % 3 )
    else
      AdanaxisRuby.cConfigDifficultySet( (AdanaxisRuby.cConfigDifficulty + 1) % 3 )
    end
  end

  def mMenuAudioVolume(params, input)
    if input < 0
      MushGame.cAudioVolumeSet( (MushGame.cAudioVolume + 100) % 110 )
    else
      MushGame.cAudioVolumeSet( (MushGame.cAudioVolume + 10) % 110 )
    end
  end

  def mMenuMusicVolume(params, input)
    if input < 0
      MushGame.cMusicVolumeSet( (MushGame.cMusicVolume + 100) % 110 )
    else
      MushGame.cMusicVolumeSet( (MushGame.cMusicVolume + 10) % 110 )
    end
  end

  def mMenuVoiceVolume(params, input)
    if input < 0
      MushGame.cVoiceVolumeSet( (MushGame.cVoiceVolume + 100) % 110 )
    else
      MushGame.cVoiceVolumeSet( (MushGame.cVoiceVolume + 10) % 110 )
    end
  end

  def mMenuTextureDetail(params, input)
    if input < 0
      MushGame.cTextureDetailSet( (MushGame.cTextureDetail + 4) % 5 )
    else
      MushGame.cTextureDetailSet( (MushGame.cTextureDetail + 1) % 5 )
    end
  end

  def mMenuGLCompression(params, input)
    case AdanaxisRuby.cUseGLCompression
      when 0: AdanaxisRuby.cUseGLCompressionSet(1)
      when 1: AdanaxisRuby.cUseGLCompressionSet(0)
    end
  end

  def mMenuGLShader(params, input)
    case AdanaxisRuby.cUseGLShader
      when 0: AdanaxisRuby.cUseGLShaderSet(1)
      when 1: AdanaxisRuby.cUseGLShaderSet(0)
    end
  end

  def mMenuMouseSensitivity(params, input)
    mouseSens = MushGame.cMouseSensitivity
    if input < 0
      mouseSens -= 0.1
    else
      mouseSens += 0.1
    end

    mouseSens = -10 if mouseSens > 10.01
    mouseSens = 10 if mouseSens < -10.01

    MushGame.cMouseSensitivitySet(mouseSens)
  end

  def mMenuBrightness(params, input)
    brightness = MushGame.cBrightness
    if input < 0
      brightness -= 0.1
    else
      brightness += 0.1
    end

    brightness = 0.1 if brightness > 2.01
    brightness = 2 if brightness < 0.09

    MushGame.cBrightnessSet(brightness)
  end

  def mMenuShowSubtitles(params, input)
    MushGame.cShowSubtitlesSet(!MushGame.cShowSubtitles)
  end

  attr_reader :spacePath, :space
end
