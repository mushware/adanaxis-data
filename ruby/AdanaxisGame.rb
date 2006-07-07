require 'Mushware.rb'

class AdanaxisGame < MushObject
  def initialize
    @spaceName = 'local1'
	@spaceObjectName = 'Adanaxis_'+@spaceName
    @spacePath = MushConfig.cGlobalSpacesPath + '/' + @spaceName
    
    @menuRender = AdanaxisRender.new
    @menuRender.mCreate
  end
  
  def mLoad
    require(@spacePath+'/space.rb')
	@space = eval "#{@spaceObjectName}.new"
	@space.mLoad
	self
  end
  
  def mRender
    @menuRender.mRender
  end

  def mKeypress(inKey, inIsDown)
    keyChar = (inKey < 256)?(inKey.chr):('?')
    keyName = MushGame.cKeySymbolToName(inKey);
    puts "key #{inKey}, '#{keyChar}' '#{keyName}' #{inIsDown}"
  end

  attr_reader :spacePath, :space
end
