#%Header {
##############################################################################
#
# File adanaxis-data/spaces/intro1/space.rb
#
# Copyright: Andy Southgate 2002-2007, 2020
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##############################################################################
#%Header } 5TK8Jaur21aVkSPE0hnDew
# $Id: space.rb,v 1.7 2007/06/27 13:18:55 southa Exp $
# $Log: space.rb,v $
# Revision 1.7  2007/06/27 13:18:55  southa
# Debian packaging
#
# Revision 1.6  2007/06/27 12:58:13  southa
# Debian packaging
#
# Revision 1.5  2007/06/16 07:13:40  southa
# Licence corrections
#
# Revision 1.4  2007/04/21 18:05:47  southa
# Level 8
#
# Revision 1.3  2007/04/19 12:57:57  southa
# Prerelease work
#
# Revision 1.2  2007/04/18 09:21:55  southa
# Header and level fixes
#
# Revision 1.1  2007/04/16 18:50:58  southa
# Voice work
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_intro1 < AdanaxisSpace
  SCENESTATE_INIT = 0
  SCENESTATE_PRETEXT_1 = 1
  SCENESTATE_TEXT_1 = 2
  SCENESTATE_ZOOM = 3
  SCENESTATE_SHOW_X = 4
  SCENESTATE_SHOW_Y = 5
  SCENESTATE_SHOW_Z = 6
  SCENESTATE_SHOW_WASD = 7
  SCENESTATE_FIRE_INFO = 8
  SCENESTATE_AXES_DONE = 9

  def initialize(inParams = {})
    super
    @m_cutScene = self
    @m_cutScenePhase = 0
  end

  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-familiarisation.ogg')
    15.times do |i|
      MushGame.cSoundDefine("voice-F#{i+1}", "mush://waves/voice-F#{i+1}.ogg|null:")
    end
  end

  def mGameInit
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
    @m_scannerValue = MushVector.new(0, 0, 0, -10)
    @m_scannerPos = MushVector.new(0, 0, 0, 0)
    @m_scannerSize = 0.02
    @m_mouseOffset = MushVector.new(0, 0, 0, 0)
    @m_text = []

    @m_singleButton = (MushGame.cPackageID =~ /-macosx-/)

    @m_positions = [
      MushVector.new(0.0, 0.0, -0.45, 0),
      MushVector.new(0.0, 0.0, -0.77, 0),
      MushVector.new(0.0, 0.0, 0.96, 0),
      MushVector.new(0.0, 0.0, 0.37, 0),
      MushVector.new(0.0, 0.0, 0.6, 0),
      MushVector.new(0.0, 0.0, -0.4, 0),
      MushVector.new(0.0, 0.0, 1.13, 0),
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

  def mPhaseTrigger(inNum)
    if inNum > @m_cutScenePhase
      @m_cutScenePhase = inNum
      if inNum.is_a? Integer
        MushGame.cVoicePlay("voice-F#{inNum}")
      end
      yield if block_given?
    end
  end

  def mCutSceneMove(inNum)
    case @m_sceneState
      when SCENESTATE_INIT
        if mStateAgeMsec > 1000
          mPhaseTrigger(1)
          mStateNext
        end

      when SCENESTATE_PRETEXT_1
        if mStateAgeMsec > 5000
          mPhaseTrigger(2) {
            @m_text = [
              "This craft is equipped with a four-dimensional",
              "control system. Aiming takes place in three",
              "distinct directions"
            ]
          }
          mStateNext
        end

      when SCENESTATE_TEXT_1
        if mStateAgeMsec > 3000
          mStateNext
        end

      when SCENESTATE_ZOOM
        @m_mouseAlpha = mStateAgeMsec / 4000.0
        @m_mouseAlpha = 1.0 if @m_mouseAlpha > 1.0

        @m_scannerSize = 0.02 + mStateAgeMsec / 40000.0
        @m_scannerSize = 0.1 if @m_scannerSize > 0.1

        if mStateAgeMsec > 6000
          mPhaseTrigger(3) {
            @m_text = [
              "Aiming in the x axis, left and right, operates",
              "as in conventional space, by moving the mouse",
              "controller left and right"
            ]
          }
          mStateNext
        end

      when SCENESTATE_SHOW_X
        if mStateAgeMsec > 12000
          mPhaseTrigger(4) {
            @m_text << ""
            @m_text << "Three-dot markers show the position of target"
            @m_text << "objects.  The red dot on the three-dot marker"
            @m_text << "shows the position of the target in x"
          }
        end

        xVal = Math.sin(Math::PI * mStateAgeMsec / 4000.0)
        @m_mouseOffset = MushVector.new(0.1*xVal, 0, 0, 0)
        @m_scannerValue.x = -xVal
        @m_scannerPos.x = -0.1*xVal
        if mStateAgeMsec > 24000
          mPhaseTrigger(5) {
            @m_text = [
              "Aiming in the y axis, up and down, operates",
              "as in conventional space, by moving the mouse",
              "controller up and down"
            ]
          }
          mStateNext
        end

      when SCENESTATE_SHOW_Y
        if mStateAgeMsec > 12000
          mPhaseTrigger(6) {
            @m_text << ""
            @m_text << "The green dot on the three-dot marker"
            @m_text << "shows the position of the target in y"
          }
        end

        yVal = Math.sin(Math::PI * mStateAgeMsec / 4000.0)
        @m_mouseOffset = MushVector.new(0, 0.1*yVal, 0, 0)
        @m_scannerValue.x = 0
        @m_scannerPos.x = 0
        @m_scannerValue.y = -yVal
        @m_scannerPos.y = -0.1*yVal
        if mStateAgeMsec > 20000
          mPhaseTrigger(7) {
            @m_text = [
              "The target environment has 4 spatial dimensions.",
              "This implies one additional aiming direction -",
              "the z or 'hidden' axis"
            ]
          }
          mStateNext
        end


      when SCENESTATE_SHOW_Z

        if mStateAgeMsec > 12000
          mPhaseTrigger(8) {
            @m_text << ""
            @m_text << "The blue dot on the three-dot marker shows"
            @m_text << "the position of the target in z"
          }
        end

        if @m_singleButton
          @m_spaceBarAlpha = ((mStateAgeMsec - 18000) / 2000.0).mClamp(0.0, 1.0)
        end

        if mStateAgeMsec > 20000

          if @m_singleButton
            mPhaseTrigger(9) {
              @m_text << ""
              @m_text << "To aim in z, hold the space bar down whilst"
              @m_text << "moving the mouse controller left and right"

              @m_spaceBarFont = MushGLFont.new(:name => "spacebarpressed1-font")
            }
          else
            mPhaseTrigger(10) {
              @m_text << ""
              @m_text << "To aim in z, hold the right mouse button down"
              @m_text << "whilst dragging the mouse controller"
              @m_text << "left and right"
              @m_mouseFont = MushGLFont.new(:name => "mouserightpressed1-font")
            }
          end
        end

        if mStateAgeMsec > 20000
          zVal = Math.sin(Math::PI * mStateAgeMsec / 4000.0)
          @m_mouseOffset = MushVector.new(0.1*zVal, 0, 0, 0)
          @m_scannerValue.y = 0
          @m_scannerPos.y = 0
          @m_scannerValue.z = -zVal
        end
        if mStateAgeMsec > 36000
          @m_mouseFont = MushGLFont.new(:name => "mouse1-font")
          @m_spaceBarFont = MushGLFont.new(:name => "spacebar1-font")
          mStateNext
        end


      when SCENESTATE_SHOW_WASD

        mPhaseTrigger(10.1) {
          @m_text = [
            "The craft can also move conventionally",
            "using the W, A, S and D keys"
          ]
        }

        if mStateAgeMsec > 6000
          mPhaseTrigger(10.2) {
            @m_text << ""
            @m_text << "The original 2006 game forgot"
            @m_text << "to mention this"
          }
        end

        if mStateAgeMsec > 9000
          mPhaseTrigger(10.3) {
            @m_text << ""
            @m_text << "So no voiceover"
          }
        end

        if mStateAgeMsec > 12000
          mPhaseTrigger(10.4) {
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << ""
            @m_text << "Awks"
          }
        end

        if mStateAgeMsec > 15000
          mPhaseTrigger(10.5) {
            @m_text << ""
            @m_text << "But let's continue..."
          }
        end

        if mStateAgeMsec > 18000 
          mStateNext
        end


      when SCENESTATE_FIRE_INFO
        @m_spaceBarAlpha = 1.0 - mStateAgeMsec / 4000.0
        @m_spaceBarAlpha = 0.0 if @m_spaceBarAlpha < 0.0

        mPhaseTrigger(11) {
          @m_text = [
            "When all three dots are at the top of the marker,",
            "the craft is aiming directly at the target"
          ]
        }

        if mStateAgeMsec > 8000
          mPhaseTrigger(12) {
            @m_text << ""
            @m_text << "When the target is in the crosshairs, the red"
            @m_text << "and green dots will already be in the correct"
            @m_text << "position.  Aiming is not complete unless the blue"
            @m_text << "dot is also at the top of the three-dot marker"
          }
        end

        if mStateAgeMsec > 12000
          posNum = ((mStateAgeMsec - 12000)/ 1000) % 12

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
        mStateNext if mStateAgeMsec > 36000

      when SCENESTATE_AXES_DONE
        mPhaseTrigger(13) {
          @m_text = [
            "Target drones have been placed in this area.",
            "Fire upon them"
          ]
        }

        @m_mouseOffset = MushVector.new(0, 0, 0, 0)
        @m_scannerValue.x /= 2
        @m_scannerValue.y /= 2
        @m_scannerValue.z /= 2
        @m_mouseAlpha = 1.0 - mStateAgeMsec / 4000.0
        @m_mouseAlpha = 0.0 if @m_mouseAlpha < 0.0
        @m_scannerSize -= 0.001 if @m_scannerSize > 0.02

        mStateNext if mStateAgeMsec > 6000
      else
        MushGame.cCutSceneModeExit
    end

    angPos = MushRotation.new

    MushTools.cRotationInXWPlane(-0.085*@m_scannerValue.x).mRotate(angPos)
    MushTools.cRotationInYWPlane(-0.085*@m_scannerValue.y).mRotate(angPos)
    MushTools.cRotationInZWPlane(-0.2*@m_scannerValue.z).mRotate(angPos)

    AdanaxisRuby.cPlayerOrientationForce(angPos);

  end

  def mInitialPiecesCreate
    super

    positions = [
      [ 10, 10, -6, -55, 0.2,0.3,0.6],
      [ 10, 0,  3, -35, 0,0.3,0.6],
      [ 10, -10, 8, -45, 0.2,0.3,0],
      [ 0, 10, -3, -45, 0.1,0.3,0.7],
      [ 0, 0, 0, -55, 0.3,0.3,0.7],
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

      khazi = mPieceLibrary.mDroneCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => pos,
          :angular_position => angPos,
          :angular_velocity => MushTools.cRandomAngularVelocity(0.005)
          )
        )
    end

    mStandardCosmos(0)

  end
end
