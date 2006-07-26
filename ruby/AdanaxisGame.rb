require 'Mushware.rb'

require 'AdanaxisLevels.rb'

class AdanaxisGame < MushObject
  def initialize
    @spaceName = 'local1'
    @levels = AdanaxisLevels.new
    
    @menuRender = AdanaxisRender.new
    @menuRender.mCreate
    
    @menuSet = AdanaxisMenu.new
    @currentMenu = 0
    @entryDisplayMode = ""
    @textureDetail = 0
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
	@space.mLoad
	self
  end
  
  def mRender(msec)
    menu = @menuSet.mMenu(@currentMenu)
    menu.highlight_colour = MushVector.new(1,1,0.7,0.5+0.25*Math.sin(msec/100.0))
    # menu.size = 0.03+0.0003*Math.sin(msec/1500.0)
    menu.mRender(msec)
  end

  def mPreCacheRender(percentage)
    @menuRender.mPreCacheRender(percentage)
  end

  def mKeypress(inKey, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    keyName = MushGame.cKeySymbolToName(inKey);
    # puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"
    
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
              @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
            end
          when MushKeys::SDLK_UP : menu.mUp
          when MushKeys::SDLK_DOWN : menu.mDown
          when MushKeys::SDLK_KP_ENTER, MushKeys::SDLK_RETURN, MushKeys::SDLK_RIGHT : menu.mEnter(self)
        end
      end
      @menuSet.mUpdate(@currentMenu)
    end
  end

  def mMenuNewGame(param)
    MushGame.cNewGameEnter
  end
  
  def mMenuResume(param)
    MushGame.cGameModeEnter
  end
  
  def mMenuQuit(param)
    MushGame.cQuit  
  end
  
  def mMenuBack(param)
    if (param)
      @currentMenu = param
    else
      @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    end    
  end

  def mToMenu(param)
    @currentMenu = param
    @menuSet.mReset(@currentMenu)

    case @currentMenu
      when AdanaxisMenu::MENU_CHOOSE_LEVEL:
        @levels.mScanForLevels
        @menuSet.mUpdateLevels(@levels.mLevelList)
    end
  end

  def mMenuAxisKey(param)
    @menuSet.mWaitForAxisKey(param)
  end

  def mMenuAxisKeyReceived(inKey, param)
    MushGame.cAxisKeySet(inKey, param)
    @menuSet.mWaitForAxisKey(nil)
  end

  def mMenuKey(param)
    @menuSet.mWaitForKey(param)
  end

  def mMenuKeyReceived(inKey, param)
    MushGame.cKeySet(inKey, param)
    @menuSet.mWaitForKey(nil)
  end

  def mMenuAxis(param)
    axis = AdanaxisControl.cNextAxis( MushGame.cAxisSymbol(param) )
    MushGame.cAxisSet(axis, param)
  end

  def mMenuUseJoystick(param)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_X, AdanaxisControl::AXIS_XW)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_Y, AdanaxisControl::AXIS_YW)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_Z, AdanaxisControl::AXIS_ZW)
    MushGame.cAxisSet(AdanaxisControl::INAXIS_STICK_W, AdanaxisControl::AXIS_W)
    MushGame.cKeySet(MushKeys::KEYSTICK_0_0, AdanaxisControl::KEY_FIRE);
  end

  def mMenuControlsDefault(param)
    MushGame.cControlsToDefaultSet
    @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
  end
  
  def mMenuGameSelect(params)
    @spaceName = params
    MushGame.cNewGameEnter
  end    

  def mMenuToOptions(params)
    @entryDisplayMode = MushGame.cDisplayModeString
    @textureDetail = MushGame.cTextureDetail
    @currentMenu = AdanaxisMenu::MENU_OPTIONS
  end

  def mMenuDisplayMode(params)
    MushGame.cNextDisplayMode
  end

  def mMenuDisplayReset(param)
    if @entryDisplayMode != MushGame.cDisplayModeString || @textureDetail != MushGame.cTextureDetail
      MushGame.cDisplayReset
    end

    if (param)
      @currentMenu = param
    else
      @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
    end    
  end

  def mMenuAudioVolume(param)
    MushGame.cAudioVolumeSet( (MushGame.cAudioVolume + 10) % 110 )
  end
  
  def mMenuMusicVolume(param)
    MushGame.cMusicVolumeSet( (MushGame.cMusicVolume + 10) % 110 )
  end
  
  def mMenuTextureDetail(param)
    MushGame.cTextureDetailSet( (MushGame.cTextureDetail + 1) % 5 )
  end
  
  attr_reader :spacePath, :space
end
