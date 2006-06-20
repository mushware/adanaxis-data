
require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local1 < AdanaxisSpace
  def initialize
  end
  
  def mLoad
    mLoadStandard
  end
  
  def mInitialPiecesCreate
    super

    rotMin = -0.01
	rotMax = 0.01
	
	(0..10).each { |i|
	  khazi = AdanaxisRuby.cKhaziCreate(i.to_s)
	  khazi.post = MushPost.new(
	    :position => MushVector.new(20*i,0,0,0)
      )
	}

  end
  
end
