#%Header {
##############################################################################
#
# File data-adanaxis/spaces/local1/space.rb
#
# Author Andy Southgate 2006
#
# This file contains original work by Andy Southgate.  The author and his
# employer (Mushware Limited) irrevocably waive all of their copyright rights
# vested in this particular version of this file to the furthest extent
# permitted.  The author and Mushware Limited also irrevocably waive any and
# all of their intellectual property rights arising from said file and its
# creation that would otherwise restrict the rights of any party to use and/or
# distribute the use of, the techniques and methods used herein.  A written
# waiver can be obtained via http://www.mushware.com/.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } e5pyDYhqQM6o/mG0mOvX9g
# $Id: space.rb,v 1.29 2006/11/21 10:08:23 southa Exp $
# $Log: space.rb,v $
# Revision 1.29  2006/11/21 10:08:23  southa
# Initial cut scene handling
#
# Revision 1.28  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.27  2006/10/18 13:22:08  southa
# World rendering
#
# Revision 1.26  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.25  2006/10/08 11:31:32  southa
# Hit points
#
# Revision 1.24  2006/10/06 14:48:17  southa
# Material animation
#
# Revision 1.23  2006/10/03 14:06:49  southa
# Khazi and projectile creation
#
# Revision 1.22  2006/09/30 13:46:32  southa
# Seek and patrol
#
# Revision 1.21  2006/09/12 15:28:49  southa
# World sphere
#
# Revision 1.20  2006/09/10 10:30:51  southa
# Shader billboarding
#
# Revision 1.19  2006/08/02 15:41:46  southa
# Prerelease work
#
# Revision 1.18  2006/08/01 23:21:48  southa
# Rendering demo content
#
# Revision 1.17  2006/08/01 17:21:19  southa
# River demo
#
# Revision 1.16  2006/08/01 13:41:14  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_local1 < AdanaxisSpace
  SCENESTATE_INIT = 0
  SCENESTATE_ZOOM = 1
  SCENESTATE_INIT1 = 2
  SCENESTATE_INIT2 = 3
  SCENESTATE_INIT3 = 4
  SCENESTATE_INIT4 = 5
  SCENESTATE_INIT4 = 6
  
  def initialize(inParams = {})
    super
    @preCached = 0
    @m_cutScene = self
  end
  
  def mLoad(game)
    mLoadStandard(game)
    MushGame.cSoundStreamDefine('intro1', MushConfig.cGlobalWavesPath+'/mushware-intro1.ogg')
    @preCached = 0
  end

  def mHandleGameStart
    super
    @m_cutScene.mCutSceneInit(0)
    MushGame.cCutSceneModeEnter(0)
  end

  def mCutSceneInit(inNum)
    @m_symbolFont = MushGLFont.new(:name => "symbol1-font")
    @m_textFont = MushGLFont.new(:name => "library-font1")
    @m_scannerValue = MushVector.new(-1, 0, 1, -10)
    @m_scannerPos = MushVector.new(0, 0, 0, 0)
    @m_scannerSize = 0.02
    mStateChange(SCENESTATE_INIT)
  end

  def mStateChange(inState)
    @m_sceneState = inState
    @m_stateMsec = MushGame.cFreeMsec
  end
  
  def mStateNext
    mStateChange(@m_sceneState + 1)
  end

  def mStateAgeMsec
    return MushGame.cFreeMsec - @m_stateMsec
  end

  def mScannerRender
    @m_symbolFont.mRenderSymbolAtSize(
      AdanaxisFontLibrary::SYMBOL_SCAN_WHITE, @m_scannerPos.x, @m_scannerPos.y, @m_scannerSize);
    
    @m_symbolFont.mRenderSymbolAtSize(
      AdanaxisFontLibrary::SYMBOL_SCAN_X,
      @m_scannerPos.x + 0.7 * @m_scannerSize * Math.sin(@m_scannerValue.x),
      @m_scannerPos.y + 0.7 * @m_scannerSize * Math.cos(@m_scannerValue.x),
      @m_scannerSize * 0.3)
      
   @m_symbolFont.mRenderSymbolAtSize(
      AdanaxisFontLibrary::SYMBOL_SCAN_Y,
      @m_scannerPos.x + 0.7 * @m_scannerSize * Math.sin(@m_scannerValue.y),
      @m_scannerPos.y + 0.7 * @m_scannerSize * Math.cos(@m_scannerValue.y),
      @m_scannerSize * 0.3)
      
   @m_symbolFont.mRenderSymbolAtSize(
      AdanaxisFontLibrary::SYMBOL_SCAN_Z,
      @m_scannerPos.x + 0.7 * @m_scannerSize * Math.sin(@m_scannerValue.z),
      @m_scannerPos.y + 0.7 * @m_scannerSize * Math.cos(@m_scannerValue.z),
      @m_scannerSize * 0.3)
  end

  def mCutSceneRender(inNum)
    mCutSceneMove(inNum)
    @m_symbolFont.colour = MushVector.new(1,1,1,1)
    @m_textFont.mRenderAtSize("Hello", 0, -0.2, 0.04);
    mScannerRender
  end
  
  def mCutSceneMove(inNum)
    case @m_sceneState
      when SCENESTATE_INIT:
        mStateNext if mStateAgeMsec > 1000
      when SCENESTATE_ZOOM:
        if @m_scannerSize >= 0.1
          mStateNext
        else
           @m_scannerSize += 0.001
        end
      end
  end

  def mPreCache
    num = @preCached
    # Must still increment @preCached if cPreCache throws
    @preCached += 1
    case (num)
      when 0..9   : MushGLTexture.cPreCache("flare#{num}-tex")
      when 10..19 : MushGLTexture.cPreCache("ember#{num-10}-tex")
      when 20..29 : MushGLTexture.cPreCache("star#{num-20}-tex")
      when 30     : MushGLTexture.cPreCache("attendant-tex")
      when 31     : MushGLTexture.cPreCache("projectile1-tex")
      when 32     : MushGLTexture.cPreCache("projectile2-tex")
    end
    
    3 * num
  end
  
  def mInitialPiecesCreate
    super

    positions = [
      [ 10, 10, -6, -55, 0.2,0.3,0.6],
      [ 10, 0,  3, -35, 0,0.3,0.6],
      [ 10, -10, 8, -45, 0.2,0.3,0],
      [ 0, 10, -3, -45, 0.3,0.3,0.7],
      [ 0, 0, -14, -55, 0,0.3,0],
      [ 0, -10, -12, -35, 0,0.3,0.6],
      [ -10, 10, 7, -45, 0.2,0.3,0],
      [ -10, 0, -3, -45, 0.3,0.3,0.7],
      [ -10, -10, 10, -40, 0.2,0.3,0.5]
      ]

    positions.each do |param|
      pos = MushVector.new(param[0], param[1], param[2], param[3])
      angPos = MushTools.cRotationInXZPlane(Math::PI * 2 * param[4]);
      MushTools.cRotationInZWPlane(Math::PI * 2 * param[5]).mRotate(angPos);
      MushTools.cRotationInYZPlane(Math::PI * 2 * param[6]).mRotate(angPos);

      khazi = AdanaxisPieceKhazi.cCreate(
        :mesh_name => "attendant",
        :hit_points => 1.0,
        :post => MushPost.new(
          :position => pos,
          :angular_position => angPos
          )
        )
    end
    
    0.times do |i|
      pos = MushTools.cRandomUnitVector * (100 + rand(400))
      world = AdanaxisWorld.new(
        :mesh_name => "star#{i % 10}",
        :post => MushPost.new(
          :position => pos
          )
        )
    end
    
          1000.times do |i|
        pos = MushTools.cRandomUnitVector * (10 + rand(40))
        world = AdanaxisWorld.new(
          :mesh_name => mMeshLibrary.mRandomCosmosName,
          :post => MushPost.new(
            :position => pos
            )
          )
      end
      
    worldMesh =  MushMesh.new("world")
    worldBase = MushBaseWorldSphere.new(
      :num_facets => 10,
      :tiles_per_texture => 1);
    worldMesh.mBaseAdd(worldBase)
    worldMesh.mMaterialAdd("star0-mat")
    worldMesh.mMake
    # puts worldMesh.to_xml
    
    #world = AdanaxisWorld.new(
    #  :mesh_name => "world"
    #)
    
    
    
  end
end
