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
# $Id: space.rb,v 1.30 2006/11/21 16:13:55 southa Exp $
# $Log: space.rb,v $
# Revision 1.30  2006/11/21 16:13:55  southa
# Cutscene handling
#
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
  SCENESTATE_TEXT_1 = 1
  SCENESTATE_ZOOM = 2
  SCENESTATE_SHOW_X = 3
  SCENESTATE_SHOW_Y = 4
  SCENESTATE_SHOW_Z = 5
  SCENESTATE_FIRE_INFO = 6
  SCENESTATE_AXES_DONE = 7
  
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
    @m_mouseFont = MushGLFont.new(:name => "mouse1-font")
    @m_spaceBarFont = MushGLFont.new(:name => "spacebar1-font")
    @m_mouseAlpha = 0.0
    @m_spaceBarAlpha = 0.0
    @m_scannerValue = MushVector.new(-1, 0, 1, -10)
    @m_scannerPos = MushVector.new(0, 0, 0, 0)
    @m_scannerSize = 0.02
    @m_mouseOffset = MushVector.new(0, 0, 0, 0)
    @m_text = []
    @m_singleButton = true
    @m_positions = [
      MushVector.new(1.1, 0.65, -1.45, 0),
      MushVector.new(0.5, -1.14, -2.77, 0),
      MushVector.new(-1.13, 0.98, 1.96, 0),
      MushVector.new(1.97, 0, 0, 0),
      MushVector.new(0.0, 0.0, 0.6, 0),
      MushVector.new(0, 0.84, 0, 0),
      MushVector.new(0.53, 2.08, 1.03, 0),
      MushVector.new(0, 0, 0, 0)
    ]
      
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

  def mMouseRender
    @m_mouseFont.colour = MushVector.new(1,1,1,@m_mouseAlpha)
    @m_mouseFont.mRenderSymbolAtSize(0,
      0.3+@m_mouseOffset.x, -0.2+@m_mouseOffset.y, 0.2)
  end

  def mSpaceBarRender
    @m_spaceBarFont.colour = MushVector.new(1,1,1,@m_spaceBarAlpha)
    @m_spaceBarFont.mRenderSymbolAtSize(0,
      -0.2, -0.2, 0.2)
  end

  def mCutSceneRender(inNum)
    mCutSceneMove(inNum)
    @m_symbolFont.colour = MushVector.new(1,1,1,1)
    @m_textFont.colour = MushVector.new(1,1,1,0.5)
    
    textBase = 0.28
    @m_text.each do |line|
      @m_textFont.mRenderAtSize(line, -0.01 * line.size, textBase, 0.02);
      textBase -= 0.022
    end
    mScannerRender
    mMouseRender if @m_mouseAlpha > 0.0
    mSpaceBarRender if @m_spaceBarAlpha > 0.0
  end
  
  def mCutSceneMove(inNum)
    case @m_sceneState
      when SCENESTATE_INIT
        mStateNext if mStateAgeMsec > 1000

      when SCENESTATE_TEXT_1
        @m_text = [
          "Your craft is equipped with a 4D control system",
          "and aiming is done in 3 different directions"
           ]
        mStateNext if mStateAgeMsec > 6000

      when SCENESTATE_ZOOM
        @m_mouseAlpha = mStateAgeMsec / 4000.0
        @m_mouseAlpha = 1.0 if @m_mouseAlpha > 1.0

        @m_scannerSize = 0.02 + mStateAgeMsec / 40000.0
        @m_scannerSize = 0.1 if @m_scannerSize > 0.1

        mStateNext if mStateAgeMsec > 4000
      
      when SCENESTATE_SHOW_X
        @m_text = [
          "Aiming left-right (the x axis) works as normal,",
          "by moving the mouse left and right",
        ]
        
        if (@m_text.size < 3 && mStateAgeMsec > 8000)
          @m_text << ""
          @m_text << "The red dot on the three-dot marker shows"
          @m_text << "the position of the target in x"
        end
        
        xVal = Math.sin(Math::PI * mStateAgeMsec / 4000.0)
        @m_mouseOffset = MushVector.new(0.1*xVal, 0, 0, 0)
        @m_scannerValue.x = -xVal
        @m_scannerPos.x = -0.1*xVal
        mStateNext if mStateAgeMsec > 16000
    
      when SCENESTATE_SHOW_Y
        @m_text = [
          "Aiming up-down (the y axis) also works as normal,",
          "by moving the mouse up and down",
        ]
        
        if (@m_text.size < 3 && mStateAgeMsec > 8000)
          @m_text << ""
          @m_text << "The green dot on the three-dot marker shows"
          @m_text << "the position of the target in y"
        end
        
        yVal = Math.sin(Math::PI * mStateAgeMsec / 4000.0)
        @m_mouseOffset = MushVector.new(0, 0.1*yVal, 0, 0)
        @m_scannerValue.x = 0
        @m_scannerPos.x = 0
        @m_scannerValue.y = -yVal
        @m_scannerPos.y = -0.1*yVal
        mStateNext if mStateAgeMsec > 16000
    
      when SCENESTATE_SHOW_Z
      
        if @m_singleButton
          @m_spaceBarAlpha = mStateAgeMsec / 4000.0
          @m_spaceBarAlpha = 1.0 if @m_spaceBarAlpha > 1.0
        end
      
        @m_text = [
          "In 4D, there's one more aiming direction.",
          "This is the 'hidden axis' (or z axis)"
        ]
        
        if (@m_text.size < 3 && mStateAgeMsec > 4000)
          @m_text << ""
          @m_text << "The blue dot on the three-dot marker shows"
          @m_text << "the position of the target in z"
        end
        
        if (@m_text.size < 6 && mStateAgeMsec > 8000)
        
          if @m_singleButton
            @m_text << ""
            @m_text << "To aim in z, hold the space bar down"
            @m_text << "whilst dragging the mouse left and right"

            @m_spaceBarFont = MushGLFont.new(:name => "spacebarpressed1-font")
          else
            @m_text << ""
            @m_text << "To aim in z, hold the right mouse button"
            @m_text << "down whilst dragging the mouse left and right"

            @m_mouseFont = MushGLFont.new(:name => "mouserightpressed1-font")
          end
        end
        
        if mStateAgeMsec > 8000
          zVal = Math.sin(Math::PI * mStateAgeMsec / 4000.0)
          @m_mouseOffset = MushVector.new(0.1*zVal, 0, 0, 0)
          @m_scannerValue.y = 0
          @m_scannerPos.y = 0
          @m_scannerValue.z = -zVal
        end
        if mStateAgeMsec > 20000
          @m_mouseFont = MushGLFont.new(:name => "mouse1-font")
          @m_spaceBarFont = MushGLFont.new(:name => "spacebar1-font")        
          mStateNext 
        end
      
      when SCENESTATE_FIRE_INFO
        @m_spaceBarAlpha = 1.0 - mStateAgeMsec / 4000.0
        @m_spaceBarAlpha = 0.0 if @m_spaceBarAlpha < 0.0
      
        @m_text = [
          "When all three are at the top of the marker,",
          "the craft is aiming directly at the target"
        ]

        if (@m_text.size < 3 && mStateAgeMsec > 4000)
          @m_text << ""
          @m_text << "Even if the target is in the crosshairs,"
          @m_text << "the craft isn't aiming at it unless the"
          @m_text << "blue dot is at the top as well."
        end

        if mStateAgeMsec > 8000
          posNum = (mStateAgeMsec / 1000) % 12

          if posNum < 7
            @m_scannerValue = @m_positions[posNum]
            @m_mouseFont = MushGLFont.new(:name => "mouse1-font")
            crossTickFont = MushGLFont.new(:name => "cross1-font")
            caption = "MISS"
          else
            @m_scannerValue = @m_positions[7]
            if mStateAgeMsec % 500 > 350
              @m_mouseFont = MushGLFont.new(:name => "mouseleftpressed1-font")
            else
              @m_mouseFont = MushGLFont.new(:name => "mouse1-font")
            end
            crossTickFont = MushGLFont.new(:name => "tick1-font")
            caption = "HIT"
          end
          @m_textFont.colour = MushVector.new(1,1,1, 1.0 - (mStateAgeMsec % 1000) / 1000.0)
          @m_textFont.mRenderAtSize(caption, -0.02 * caption.size, -0.1, 0.04)
          crossTickFont.colour = MushVector.new(1,1,1,0.5)
          crossTickFont.mRenderAtSize(0, 0.1, 0, 0.2)
        end
        mStateNext if mStateAgeMsec > 24000

      when SCENESTATE_AXES_DONE
        @m_text = [
          "Try shooting the target drones in front of you"
        ]

        @m_mouseOffset = MushVector.new(0, 0, 0, 0)
        @m_scannerValue.z = 0
        @m_mouseAlpha = 1.0 - mStateAgeMsec / 4000.0
        @m_mouseAlpha = 0.0 if @m_mouseAlpha < 0.0
        @m_scannerSize -= 0.001 if @m_scannerSize < 0.02
        
        mStateNext if mStateAgeMsec > 5000
      else
        MushGame.cCutSceneModeExit
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
      [ 0, 0, 0, -55, 0,0.3,0],
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
