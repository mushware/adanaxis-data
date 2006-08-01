#%Header {
##############################################################################
#
# File: data-adanaxis/ruby/AdanaxisGame.rb
#
# Copyright: Andy Southgate 2006
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
#%Header } Keyr0cDT/SIta54pYcV7Bw
# $Id$
# $Log$

require 'Mushware.rb'

require 'AdanaxisLevels.rb'

class AdanaxisGame < MushObject
  def initialize
    @spaceName = 'menu1'
    @levels = AdanaxisLevels.new
    
    @menuRender = AdanaxisRender.new
    @menuRender.mCreate
    
    @menuSet = AdanaxisMenu.new
    @currentMenu = 0
    @entryDisplayMode = ""
    @textureDetail = 0
    @showHidden = false;
  end
  
  def mSpaceName
    @spaceName
  end
  
  def mSpaceObjectName
    'Adanaxis_'+@spaceName
  end
 
  def mSpacePath
    MushConfig.cGlobalSpacesPath + '/' + @spaceName  
  end
  
  def mLoad
    require(mSpacePath+'/space.rb')
	@space = eval "#{mSpaceObjectName}.new"
	@space.mLoad(self)
	self
  end
  
  def mRender(msec)
    menu = @menuSet.mMenu(@currentMenu)
    menu.highlight_colour = MushVector.new(1,1,0.7,0.5+0.25*Math.sin(msec/100.0))
    # menu.size = 0.03+0.0003*Math.sin(msec/1500.0)
    menu.mRender(msec)
    @menuRender.mPackageIDRender
  end

  def mPreCacheRender(percentage)
    @menuRender.mPreCacheRender(percentage)
  end

  def mReset(allowResume)
    @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    @menuSet.mReset(@currentMenu)
    @menuSet.allowResume = allowResume
    @menuSet.mUpdate(@currentMenu)
  end

  def mKeypress(inKey, inModifier, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    keyName = MushGame.cKeySymbolToName(inKey);
    # puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"
    
    @showHidden = ((inModifier & MushKeys::KMOD_SHIFT) != 0)
    
    if inIsDown
      menu = @menuSet.mMenu(@currentMenu)
      
      if (@menuSet.axisKeyWait || @menuSet.keyWait)
        inKey == 27 && inKey = 0
        menu.mKeypress(self, inKey)
      else
        case inKey
          when MushKeys::SDLK_ESCAPE
            if @currentMenu == AdanaxisMenu::MENU_TOPLEVEL
              MushGame.cGameModeEnter
            else
              if @currentMenu == AdanaxisMenu::MENU_OPTIONS &&
                (@entryDisplayMode != MushGame.cDisplayModeString || @textureDetail != MushGame.cTextureDetail)
                MushGame.cDisplayReset
              end
              @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
            end
          when MushKeys::SDLK_UP : menu.mUp
          when MushKeys::SDLK_DOWN : menu.mDown
          when MushKeys::SDLK_KP_ENTER, MushKeys::SDLK_RETURN: menu.mEnter(self)
          when MushKeys::SDLK_LEFT: menu.mLeft(self)
          when MushKeys::SDLK_RIGHT: menu.mRight(self)
        end
      end
      @menuSet.mUpdate(@currentMenu)
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
      @currentMenu = param
    else
      @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    end    
  end

  def mToMenu(param, input)
    @currentMenu = param
    @menuSet.mReset(@currentMenu)

    case @currentMenu
      when AdanaxisMenu::MENU_CHOOSE_LEVEL:
        @levels.mScanForLevels
        @menuSet.mUpdateLevels(@levels.mLevelList, @showHidden)
    end
  end

  def mMenuAxisKey(param, input)
    @menuSet.mWaitForAxisKey(param)
  end

  def mMenuAxisKeyReceived(inKey, param)
    MushGame.cAxisKeySet(inKey, param)
    @menuSet.mWaitForAxisKey(nil)
  end

  def mMenuKey(param, input)
    @menuSet.mWaitForKey(param)
  end

  def mMenuKeyReceived(inKey, param)
    MushGame.cKeySet(inKey, param)
    @menuSet.mWaitForKey(nil)
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
    @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
  end
  
  def mMenuGameSelect(params, input)
    @spaceName = params
    MushGame.cNewGameEnter
  end    

  def mMenuToOptions(params, input)
    @entryDisplayMode = MushGame.cDisplayModeString
    @textureDetail = MushGame.cTextureDetail
    @currentMenu = AdanaxisMenu::MENU_OPTIONS
  end

  def mMenuDisplayMode(params, input)
    if (input < 0)
      MushGame.cPreviousDisplayMode
    else
      MushGame.cNextDisplayMode
    end
  end

  def mMenuDisplayReset(params, input)
    if @entryDisplayMode != MushGame.cDisplayModeString || @textureDetail != MushGame.cTextureDetail
      MushGame.cDisplayReset
    end

    if (params)
      @currentMenu = params
    else
      @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
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
