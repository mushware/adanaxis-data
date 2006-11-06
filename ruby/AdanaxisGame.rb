#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisGame.rb
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
#%Header } KSO1aRs/aLEv+/QhWfRoRw
# $Id: AdanaxisGame.rb,v 1.23 2006/11/06 12:56:31 southa Exp $
# $Log: AdanaxisGame.rb,v $
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
  
  mush_accessor :m_space, :m_view
  
  def mSpaceName
    @m_spaceName
  end
  
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
    require(mSpacePath+'/space.rb')
    @m_space = eval("#{mSpaceObjectName}.new", binding, mSpacePath+'/space.rb', 1)
    @m_space.mLoad(self)
    self
  end
  
  def mRender(inParams = {})
    @m_view.mDashboardRender(inParams)
  end
  
  def mMenuRender(msec)
    menu = @m_menuSet.mMenu(@m_currentMenu)
    menu.highlight_colour = MushVector.new(1,1,0.7,0.5+0.25*Math.sin(msec/100.0))
    # menu.size = 0.03+0.0003*Math.sin(msec/1500.0)
    menu.mRender(msec)
    @m_menuRender.mPackageIDRender
  end

  def mPreCacheRender(percentage)
    @m_menuRender.mPreCacheRender(percentage)
  end

  def mReset(allowResume)
    @m_currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    @m_menuSet.mReset(@m_currentMenu)
    @m_menuSet.allowResume = allowResume
    @m_menuSet.mUpdate(@m_currentMenu)
  end

  def mKeypress(inKey, inModifier, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    keyName = MushGame.cKeySymbolToName(inKey);
    # puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"
    
    @m_showHidden = ((inModifier & MushKeys::KMOD_SHIFT) != 0)
    
    if inIsDown
      menu = @m_menuSet.mMenu(@m_currentMenu)
      
      if (@m_menuSet.axisKeyWait || @m_menuSet.keyWait)
        inKey == 27 && inKey = 0
        menu.mKeypress(self, inKey)
      else
        case inKey
          when MushKeys::SDLK_ESCAPE
            if @m_currentMenu == AdanaxisMenu::MENU_TOPLEVEL
              MushGame.cGameModeEnter
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
  
  def mMenuTextureDetail(params, input)
    if input < 0
      MushGame.cTextureDetailSet( (MushGame.cTextureDetail + 4) % 5 )
    else
      MushGame.cTextureDetailSet( (MushGame.cTextureDetail + 1) % 5 )
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
  
  
  
  attr_reader :spacePath, :space
end
