require 'Mushware.rb'

class AdanaxisGame < MushObject
  def initialize
    @spaceName = 'local1'
	@spaceObjectName = 'Adanaxis_'+@spaceName
    @spacePath = MushConfig.cGlobalSpacesPath + '/' + @spaceName
  end
  
  def mLoad
    require(@spacePath+'/space.rb')
	@space = eval "#{@spaceObjectName}.new"
	@space.mLoad
	self
  end
  
  attr_reader :spacePath, :space
end
