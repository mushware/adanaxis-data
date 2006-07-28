
class AdanaxisSpace < MushObject
  def mLoadStandard
    AdanaxisFontLibrary.cCreate
	AdanaxisMeshLibrary.cCreate
	AdanaxisMaterialLibrary.cCreate
    AdanaxisTextureLibrary.cCreate
  end
  
  def mPreCache
    # Stop precaching by returning 100%
    100
  end
  
  def mInitialPiecesCreate
  end
  
  def mIsMenuBackdrop
    false
  end  
end
