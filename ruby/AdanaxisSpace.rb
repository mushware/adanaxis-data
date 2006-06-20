
class AdanaxisSpace < MushObject
  def mLoadStandard
	AdanaxisMeshLibrary.cCreate
	AdanaxisMaterialLibrary.cCreate
    AdanaxisTextureLibrary.cCreate
  end
  
  def mInitialPiecesCreate
  end
end
