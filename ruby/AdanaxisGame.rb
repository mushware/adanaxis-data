require 'Mushware.rb'

class AdanaxisGame < MushObject
  def initialize
    @spaceName = 'local1'
	@spaceObjectName = 'Adanaxis_'+@spaceName
    @spacePath = MushConfig.cGlobalSpacesPath + '/' + @spaceName
    
    @menuRender = AdanaxisRender.new
    @menuRender.mCreate
    
    @menu = MushMenu.new(
      :menu => [  
        ["New Game", :mNewGame],
        ["Resume", :mResume],
        ["Quit", :mQuit]
      ],
      :size => 0.025,
      :colour => MushVector.new(0.7,0.7,1,0.7)
    )
  end
  
  def mNewGame
    MushGame.cGameModeEnter
  end
  
  def mResume
    MushGame.cGameModeEnter
  end
  
  def mQuit
    MushGame.cQuit  
  end
  
  def mLoad
    require(@spacePath+'/space.rb')
	@space = eval "#{@spaceObjectName}.new"
	@space.mLoad
	self
  end
  
  def mRender(msec)
    @menu.highlight_colour = MushVector.new(1,1,0.7,0.5+0.25*Math.sin(msec/100.0))
    @menu.size = 0.03+0.0003*Math.sin(msec/1500.0)
    @menu.mRender(msec)
  end

  def mKeypress(inKey, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    keyName = MushGame.cKeySymbolToName(inKey);
    # puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"
    
    if inIsDown
      case inKey
        when MushKeys::SDLK_ESCAPE : MushGame.cGameModeEnter
        when MushKeys::SDLK_UP : @menu.mUp
        when MushKeys::SDLK_DOWN : @menu.mDown
        when MushKeys::SDLK_KP_ENTER, MushKeys::SDLK_RETURN : @menu.mEnter(self)
      end
    end
  end

  attr_reader :spacePath, :space
end
