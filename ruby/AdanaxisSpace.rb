#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisSpace.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } lR/lFdEFyXBbk1T1wsvmCw
# $Id: AdanaxisSpace.rb,v 1.10 2006/10/06 14:48:17 southa Exp $
# $Log: AdanaxisSpace.rb,v $
# Revision 1.10  2006/10/06 14:48:17  southa
# Material animation
#
# Revision 1.9  2006/09/07 10:02:36  southa
# Shader interface
#
# Revision 1.8  2006/08/01 17:21:18  southa
# River demo
#
# Revision 1.7  2006/08/01 13:41:12  southa
# Pre-release updates
#

class AdanaxisSpace < MushObject
  def initialize(inParams = {})
    @startShown = false
    @m_textureLibrary = AdanaxisTextureLibrary.new
    @m_materialLibrary = AdanaxisMaterialLibrary.new(:texture_library => @m_textureLibrary)
    @m_meshLibrary = AdanaxisMeshLibrary.new(:texture_library => @m_textureLibrary)
  end
  
  mush_reader :m_textureLibrary, :m_materialLibrary, :m_meshLibrary
  
  def mLoadStandard(game)
    AdanaxisFontLibrary.cCreate
    @m_textureLibrary.mCreate
	  @m_materialLibrary.mCreate
	  @m_meshLibrary.mCreate
    AdanaxisShaderLibrary.cCreate
    
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
