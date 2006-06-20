
class MushConfig
  def initialize
  end

  def self.cApplPath
    $MUSHCONFIG['APPLPATH']
  end
  def self.cGlobalPixelsPath
    $MUSHCONFIG['APPLPATH']+"/pixels"
  end
  def self.cGlobalSpacesPath
    $MUSHCONFIG['APPLPATH']+"/spaces"
  end

end
