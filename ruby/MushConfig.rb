
class MushConfig
  def initialize
  end

  def MushConfig::ApplPath
    $MUSHCONFIG['APPLPATH']
  end
  def MushConfig::GlobalPixelsPath
    $MUSHCONFIG['APPLPATH']+"/pixels"
  end

end
