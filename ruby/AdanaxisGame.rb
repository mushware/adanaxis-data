require 'Mushware.rb'

class AdanaxisGame < MushObject
  def initialize
    @spaceName = 'local1'
	@spaceObjectName = 'Adanaxis_'+@spaceName
    @spacePath = MushConfig.cGlobalSpacesPath + '/' + @spaceName
    
    @menuRender = AdanaxisRender.new
    @menuRender.mCreate
    
    @menuSet = AdanaxisMenu.new
    @currentMenu = 0

  end
  
  def mMenuNewGame
    MushGame.cGameModeEnter
  end
  
  def mMenuResume
    MushGame.cGameModeEnter
  end
  
  def mMenuQuit
    MushGame.cQuit  
  end
  
  def mLoad
    require(@spacePath+'/space.rb')
	@space = eval "#{@spaceObjectName}.new"
	@space.mLoad
	self
  end
  
  def mRender(msec)
    menu = @menuSet.mMenu(@currentMenu)
    menu.highlight_colour = MushVector.new(1,1,0.7,0.5+0.25*Math.sin(msec/100.0))
    menu.size = 0.03+0.0003*Math.sin(msec/1500.0)
    menu.mRender(msec)
  end

  def mKeypress(inKey, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    keyName = MushGame.cKeySymbolToName(inKey);
    # puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"
    
    if inIsDown
      menu = @menuSet.mMenu(@currentMenu)
      case inKey
        when MushKeys::SDLK_ESCAPE : MushGame.cGameModeEnter
        when MushKeys::SDLK_UP : menu.mUp
        when MushKeys::SDLK_DOWN : menu.mDown
        when MushKeys::SDLK_KP_ENTER, MushKeys::SDLK_RETURN : menu.mEnter(self)
      end
    @menuSet.mUpdate(@currentMenu)
    end
  end

  def mMenuBack
    @currentMenu = AdanaxisMenu::MENU_TOPLEVEL
  end

  def mMenuControls
    @currentMenu = AdanaxisMenu::MENU_CONTROL
  end

  def mMenuKeys
    @currentMenu = AdanaxisMenu::MENU_KEYS
  end

  def mMenuMouse
    @currentMenu = AdanaxisMenu::MENU_MOUSE
  end

  attr_reader :spacePath, :space
end
