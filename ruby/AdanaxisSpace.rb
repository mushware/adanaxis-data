
class AdanaxisSpace < MushObject
  def initialize
    @startShown = false
  end
  
  def mLoadStandard(game)
    AdanaxisFontLibrary.cCreate
	AdanaxisMeshLibrary.cCreate
	AdanaxisMaterialLibrary.cCreate
    AdanaxisTextureLibrary.cCreate
    
    dialogueFile = game.mSpacePath+"/dialogues.xml"
    if File.file?(dialogueFile)
      MushGame.cGameDialoguesLoad(dialogueFile)
    end
  end
  
  def mPreCache
    # Stop precaching by returning 100%
    100
  end
  
  def mHandleGameStart
    MushGame.cNamedDialoguesAdd('^start') unless @startShown
    @startShown = true
  end
  
  def mInitialPiecesCreate
  end
  
  def mIsMenuBackdrop
    false
  end  
end
