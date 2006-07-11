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
  
  def mLoad
    require(@spacePath+'/space.rb')
	@space = eval "#{@spaceObjectName}.new"
	@space.mLoad
	self
  end
  
  def mRender(msec)
    menu = @menuSet.mMenu(@currentMenu)
    menu.highlight_colour = MushVector.new(1,1,0.7,0.5+0.25*Math.sin(msec/100.0))
    # menu.size = 0.03+0.0003*Math.sin(msec/1500.0)
    menu.mRender(msec)
  end

  def mKeypress(inKey, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    keyName = MushGame.cKeySymbolToName(inKey);
    # puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"
    
    if inIsDown
      menu = @menuSet.mMenu(@currentMenu)
      
      if (@menuSet.axisKeyWait)
        menu.mKeypress(self, inKey)
      else
        case inKey
          when MushKeys::SDLK_ESCAPE : MushGame.cGameModeEnter
          when MushKeys::SDLK_UP : menu.mUp
          when MushKeys::SDLK_DOWN : menu.mDown
          when MushKeys::SDLK_KP_ENTER, MushKeys::SDLK_RETURN : menu.mEnter(self)
        end
      end
      @menuSet.mUpdate(@currentMenu)
    end
  end

  def mMenuNewGame(param)
    MushGame.cGameModeEnter
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
  end

  def mMenuAxisKey(param)
    @menuSet.mWaitForAxisKey(param)
  end

  def mMenuAxisKeyReceived(inKey, param)
    MushGame.cAxisKeySet(inKey, param)
    @menuSet.mWaitForAxisKey(nil)
  end

  attr_reader :spacePath, :space
end
