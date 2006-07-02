
class AdanaxisSpace < MushObject
  def mLoadStandard
    AdanaxisFontLibrary.cCreate
	AdanaxisMeshLibrary.cCreate
	AdanaxisMaterialLibrary.cCreate
    AdanaxisTextureLibrary.cCreate
  end
  
  def mInitialPiecesCreate
  end
end
