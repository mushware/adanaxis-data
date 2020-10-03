#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisMenu.rb
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
#%Header } 6aDb1I2qejZ3HeKBFwpyrQ
# $Id: AdanaxisMenu.rb,v 1.28 2007/06/30 11:45:42 southa Exp $
# $Log: AdanaxisMenu.rb,v $
# Revision 1.28  2007/06/30 11:45:42  southa
# X11 release
#
# Revision 1.27  2007/06/27 13:18:54  southa
# Debian packaging
#
# Revision 1.26  2007/06/27 12:58:11  southa
# Debian packaging
#
# Revision 1.25  2007/06/15 12:45:48  southa
# Prerelease work
#
# Revision 1.24  2007/06/02 15:56:56  southa
# Shader fix and prerelease work
#
# Revision 1.23  2007/04/20 16:46:03  southa
# Key configuration fix
#
# Revision 1.22  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.21  2007/04/16 18:50:57  southa
# Voice work
#
# Revision 1.20  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.19  2007/03/20 17:31:23  southa
# Difficulty and GL options
#
# Revision 1.18  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.17  2007/03/07 11:29:23  southa
# Level permission
#
# Revision 1.16  2006/11/08 18:30:53  southa
# Key and axis configuration
#
# Revision 1.15  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.14  2006/08/24 13:04:37  southa
# Event handling
#
# Revision 1.13  2006/08/01 17:21:18  southa
# River demo
#
# Revision 1.12  2006/08/01 13:41:12  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'AdanaxisControl.rb'

class AdanaxisMenu < MushObject
  MENU_TOPLEVEL = 0
  MENU_CONTROL = 1
  MENU_KEYS = 2
  MENU_MOUSE = 3
  MENU_JOYSTICK = 4
  MENU_ADV_AXES = 5
  MENU_ADV_KEYS = 6
  MENU_CHOOSE_LEVEL = 7
  MENU_OPTIONS = 8

  def initialize
    @m_menuCommon = {
      :size => 0.02,
      :colour => MushVector.new(0.7,0.7,1,0.7),
      :title_colour => MushVector.new(1,1,1,0.7),
      :grey_colour => MushVector.new(1,1,1,0.3)
    }

    @m_topLevelMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Adanaxis",
          :menu => [
            ["(Requires update)", :mResume],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_controlMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Controls",
          :menu => [
            ["Keys", :mToMenu, MENU_KEYS],
            ["Mouse", :mToMenu, MENU_MOUSE],
            ["Joystick", :mToMenu, MENU_JOYSTICK],
            ["Reset to Default", :mMenuControlsDefault],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_keysMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Key Controls",
          :menu => [
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_mouseMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Mouse Control",
          :menu => [
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_joystickMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Joystick Control",
          :menu => [
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )


    @m_advAxesMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Advanced Axes",
          :menu => [
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_advKeysMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Advanced Keys",
          :menu => [
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_chooseLevelMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Choose level",
          :leftright => true,
          :menu => [
            ["(Requires update)", :mMenuBack, MENU_TOPLEVEL],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_optionsMenu = MushMenu.new(
      @m_menuCommon.merge(
        {
          :title => "Options",
          :leftright => true,
          :menu => [
            ["(Requires update)", :mMenuBack, MENU_TOPLEVEL],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @m_menuSet = [
      @m_topLevelMenu,
      @m_controlMenu,
      @m_keysMenu,
      @m_mouseMenu,
      @m_joystickMenu,
      @m_advAxesMenu,
      @m_advKeysMenu,
      @m_chooseLevelMenu,
      @m_optionsMenu
    ]
    @m_axisKeyWait = nil
    @m_keyWait = nil
    @m_allowResume = false
  end

  mush_reader :m_axisKeyWait, :m_keyWait
  mush_accessor :m_allowResume

  def mAxisMenuEntry(name, which)
    [ name+AdanaxisControl.cAxisName(which),
      :mMenuAxis,
      which
    ]
  end

  def mAxisKeyMenuEntry(name, which)
    if @m_axisKeyWait == which
      [ name+"<press>",
        :mMenuAxisKeyReceived,
        which
      ]
    else
      [ name+AdanaxisControl.cAxisKeyName(which),
        :mMenuAxisKey,
        which
      ]
    end
  end

  def mKeyMenuEntry(name, which)
    if @m_keyWait == which
      [ name+"<press>",
        :mMenuKeyReceived,
        which
      ]
    else
      [ name+AdanaxisControl.cKeyName(which),
        :mMenuKey,
        which
      ]
    end
  end

  def mNewLevelMenuEntry(name, level)
    permit = level[AdanaxisLevels::PARAMS]['permit']
    if permit && !AdanaxisRuby.cRecordTime(permit)
      flags = {:grey => true}
    end
    if level[AdanaxisLevels::PARAMS]['unavailable']
      flags = {:grey => true}
      name = ' ('+name+')'
    end
    [ name, :mMenuGameSelect, level[AdanaxisLevels::KEY], flags ]
  end

  def mReset(menu)
    @m_menuSet[menu].current = 0
  end

  def mUpdateLevels(levelList, showHidden)
    @m_menuSet[MENU_CHOOSE_LEVEL].menu = []
    levelList.each do |level|
      next if !showHidden && level[AdanaxisLevels::PARAMS]['visibility'] == 'hidden'
      name = level[AdanaxisLevels::PARAMS]['name'] || level[AdanaxisLevels::KEY]
      @m_menuSet[MENU_CHOOSE_LEVEL].menu.push mNewLevelMenuEntry(name, level)
    end
    @m_menuSet[MENU_CHOOSE_LEVEL].menu.push ["Back", :mMenuBack, MENU_TOPLEVEL]
  end

  def mUpdate(menu)
    if menu == MENU_TOPLEVEL
      if (MushGame.cPackageID =~ /-x11-/)
        menuArray = [
              ["New Game", :mToMenu, MENU_CHOOSE_LEVEL],
              ["Controls", :mToMenu, MENU_CONTROL],
              ["Options", :mMenuToOptions],
              ["Read Game Info PDF", :mMenuQuitToHelp],
              ["Quit", :mMenuQuit]
            ]
      else
        menuArray = [
              ["New Game", :mToMenu, MENU_CHOOSE_LEVEL],
              ["Controls", :mToMenu, MENU_CONTROL],
              ["Options", :mMenuToOptions],
              ["Quit", :mMenuQuit]
            ]
      end
       
      if @m_allowResume
        menuArray.unshift ["Resume", :mMenuResume]
      end

      @m_menuSet[MENU_TOPLEVEL].menu = menuArray
    end

    if menu == MENU_KEYS
      @m_menuSet[MENU_KEYS].menu = [
        mAxisKeyMenuEntry("Dodge left      : ", AdanaxisControl::AXISKEY_X_MINUS),
        mAxisKeyMenuEntry("Dodge right     : ", AdanaxisControl::AXISKEY_X_PLUS),
        mAxisKeyMenuEntry("Forward         : ", AdanaxisControl::AXISKEY_W_MINUS),
        mAxisKeyMenuEntry("Backward        : ", AdanaxisControl::AXISKEY_W_PLUS),
        mKeyMenuEntry(    "Fire            : ", AdanaxisControl::KEY_FIRE),
        mKeyMenuEntry(    "Scanner         : ", AdanaxisControl::KEY_SCANNER),
        mKeyMenuEntry(    "Previous weapon : ", AdanaxisControl::KEY_WEAPON_PREVIOUS),
        mKeyMenuEntry(    "Next weapon     : ", AdanaxisControl::KEY_WEAPON_NEXT),
        ["Advanced keys", :mToMenu, MENU_ADV_KEYS],
        ["Back", :mMenuBack, MENU_CONTROL]
      ]
    end

    if menu == MENU_MOUSE
      @m_menuSet[MENU_MOUSE].menu = [
        mAxisMenuEntry(   "Aim left/right        : ", AdanaxisControl::AXIS_XW),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_XW_REQUIRED),
        mAxisMenuEntry(   "Aim up/down           : ", AdanaxisControl::AXIS_YW),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_YW_REQUIRED),
        mAxisMenuEntry(   "Aim in hidden axis    : ", AdanaxisControl::AXIS_ZW),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_ZW_REQUIRED),
        ["Advanced axes", :mToMenu, MENU_ADV_AXES],
        ["Back", :mMenuBack, MENU_CONTROL]
      ]
    end

    if menu == MENU_JOYSTICK
      @m_menuSet[MENU_JOYSTICK].menu = [
        ["Use joystick", :mMenuUseJoystick],
        mAxisMenuEntry("Aim left/right        : ", AdanaxisControl::AXIS_XW),
        mAxisMenuEntry("Aim up/down           : ", AdanaxisControl::AXIS_YW),
        mAxisMenuEntry("Aim in hidden axis    : ", AdanaxisControl::AXIS_ZW),
        mAxisMenuEntry("Throttle              : ", AdanaxisControl::AXIS_W),
        ["Advanced axes", :mToMenu, MENU_ADV_AXES],
        ["Back", :mMenuBack, MENU_CONTROL]
      ]
    end

    if menu == MENU_ADV_AXES
      @m_menuSet[MENU_ADV_AXES].menu = [
        mAxisMenuEntry(   "Move X                : ", AdanaxisControl::AXIS_X),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_X_REQUIRED),
        mAxisMenuEntry(   "Move Y                : ", AdanaxisControl::AXIS_Y),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_Y_REQUIRED),
        mAxisMenuEntry(   "Move Z                : ", AdanaxisControl::AXIS_Z),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_Z_REQUIRED),
        mAxisMenuEntry(   "Move W                : ", AdanaxisControl::AXIS_W),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_W_REQUIRED),

        mAxisMenuEntry(   "Rotate XY             : ", AdanaxisControl::AXIS_XY),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_XY_REQUIRED),
        mAxisMenuEntry(   "Rotate ZW             : ", AdanaxisControl::AXIS_ZW),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_ZW_REQUIRED),
        mAxisMenuEntry(   "Rotate XZ             : ", AdanaxisControl::AXIS_XZ),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_XZ_REQUIRED),
        mAxisMenuEntry(   "Rotate YW             : ", AdanaxisControl::AXIS_YW),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_YW_REQUIRED),
        mAxisMenuEntry(   "Rotate XW             : ", AdanaxisControl::AXIS_XW),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_XW_REQUIRED),
        mAxisMenuEntry(   "Rotate YZ             : ", AdanaxisControl::AXIS_YZ),
        mAxisKeyMenuEntry(" - only with keypress : ", AdanaxisControl::AXISKEY_YZ_REQUIRED),

        ["Back", :mMenuBack, MENU_CONTROL]
      ]
    end

    if menu == MENU_ADV_KEYS
      @m_menuSet[MENU_ADV_KEYS].menu = [
        mKeyMenuEntry("Weapon 0              : ", AdanaxisControl::KEY_WEAPON_0),
        mKeyMenuEntry("Weapon 1              : ", AdanaxisControl::KEY_WEAPON_1),
        mKeyMenuEntry("Weapon 2              : ", AdanaxisControl::KEY_WEAPON_2),
        mKeyMenuEntry("Weapon 3              : ", AdanaxisControl::KEY_WEAPON_3),
        mKeyMenuEntry("Weapon 4              : ", AdanaxisControl::KEY_WEAPON_4),
        mKeyMenuEntry("Weapon 5              : ", AdanaxisControl::KEY_WEAPON_5),
        mKeyMenuEntry("Weapon 6              : ", AdanaxisControl::KEY_WEAPON_6),
        mKeyMenuEntry("Weapon 7              : ", AdanaxisControl::KEY_WEAPON_7),
        mKeyMenuEntry("Weapon 8              : ", AdanaxisControl::KEY_WEAPON_8),
        mKeyMenuEntry("Weapon 9              : ", AdanaxisControl::KEY_WEAPON_9),

        mAxisKeyMenuEntry("Move X negative       : ", AdanaxisControl::AXISKEY_X_MINUS),
        mAxisKeyMenuEntry("Move X positive       : ", AdanaxisControl::AXISKEY_X_PLUS),
        mAxisKeyMenuEntry("Move Y negative       : ", AdanaxisControl::AXISKEY_Y_MINUS),
        mAxisKeyMenuEntry("Move Y positive       : ", AdanaxisControl::AXISKEY_Y_PLUS),
        mAxisKeyMenuEntry("Move Z negative       : ", AdanaxisControl::AXISKEY_Z_MINUS),
        mAxisKeyMenuEntry("Move Z positive       : ", AdanaxisControl::AXISKEY_Z_PLUS),
        mAxisKeyMenuEntry("Move W negative       : ", AdanaxisControl::AXISKEY_W_MINUS),
        mAxisKeyMenuEntry("Move W positive       : ", AdanaxisControl::AXISKEY_W_PLUS),

        mAxisKeyMenuEntry("Rotate XY negative    : ", AdanaxisControl::AXISKEY_XY_MINUS),
        mAxisKeyMenuEntry("Rotate XY positive    : ", AdanaxisControl::AXISKEY_XY_PLUS),
        mAxisKeyMenuEntry("Rotate ZW negative    : ", AdanaxisControl::AXISKEY_ZW_MINUS),
        mAxisKeyMenuEntry("Rotate ZW positive    : ", AdanaxisControl::AXISKEY_ZW_PLUS),
        mAxisKeyMenuEntry("Rotate XZ negative    : ", AdanaxisControl::AXISKEY_XZ_MINUS),
        mAxisKeyMenuEntry("Rotate XZ positive    : ", AdanaxisControl::AXISKEY_XZ_PLUS),
        mAxisKeyMenuEntry("Rotate YW negative    : ", AdanaxisControl::AXISKEY_YW_MINUS),
        mAxisKeyMenuEntry("Rotate YW positive    : ", AdanaxisControl::AXISKEY_YW_PLUS),
        mAxisKeyMenuEntry("Rotate XW negative    : ", AdanaxisControl::AXISKEY_XW_MINUS),
        mAxisKeyMenuEntry("Rotate XW positive    : ", AdanaxisControl::AXISKEY_XW_PLUS),
        mAxisKeyMenuEntry("Rotate YZ negative    : ", AdanaxisControl::AXISKEY_YZ_MINUS),
        mAxisKeyMenuEntry("Rotate YZ positive    : ", AdanaxisControl::AXISKEY_YZ_PLUS),

        ["Back", :mMenuBack, MENU_CONTROL]
      ]
    end

    if menu == MENU_OPTIONS
      detailName = case MushGame.cTextureDetail
        when 0: "Low"
        when 1: "Medium"
        when 2: "High"
        when 3:
          if AdanaxisRuby.cUseGLCompression == 1:
            "Very high (>256MB)"
          else
            "Very high (>1GB)"
          end
        when 4:
          if AdanaxisRuby.cUseGLCompression == 1:
            "Vast (>1GB)"
          else
            "Vast (>4GB)"
          end
        when 5:
          if AdanaxisRuby.cUseGLCompression == 1:
            "Behemoth (>4GB)"
          else
            "Behemoth (>16GB)"
          end
        else "Unknown"
      end
      
      difficultyName = case AdanaxisRuby.cConfigDifficulty
        when 0: "Easy"
        when 1: "Normal"
        when 2: "Hard"
        when 3: "Madness"
        else "Unknown"
      end
      
      useGLCompressionName = case AdanaxisRuby.cUseGLCompression
        when 0: "No"
        when 1: "Yes (can be very slow)"
        when 2: "Unavailable"
        else "Unknown"
      end
      
      useGLShaderName = case AdanaxisRuby.cUseGLShader
        when 0: "No"
        when 1: "Yes"
        when 2: "Unavailable"
        else "Unknown"
      end
      
      if MushGame.cShowSubtitles
        showSubtitlesName = 'Yes'
      else
        showSubtitlesName = 'No'
      end

      apply2020MakeoverName = case AdanaxisRuby.cApply2020Makeover
        when 0: "No"
        when 1: "Yes"
        else "Unknown"
      end

      showFpsName = case AdanaxisRuby.cShowFps
        when 0: "No"
        when 1: "Yes"
        else "Unknown"
      end

      @m_menuSet[MENU_OPTIONS].menu = [
        ["Display mode         : "+MushGame.cDisplayModeString, :mMenuDisplayMode],
        ["Game difficulty      : #{difficultyName}", :mMenuDifficulty],
        ["Audio volume         : #{MushGame.cAudioVolume}%", :mMenuAudioVolume],
        ["Music volume         : #{MushGame.cMusicVolume}%", :mMenuMusicVolume],
        ["Voiceover volume     : #{MushGame.cVoiceVolume}%", :mMenuVoiceVolume],
        ["Texture detail (RAM) : #{detailName}", :mMenuTextureDetail],
        ["Brightness           : #{'%2.2f'%MushGame.cBrightness}", :mMenuBrightness],
        ["Show subtitles       : #{showSubtitlesName}", :mMenuShowSubtitles],
        ["Mouse sensitivity    : #{'%2.2f'%MushGame.cMouseSensitivity}", :mMenuMouseSensitivity],
        ["Texture compression  : #{useGLCompressionName}", :mMenuGLCompression],
        ["Use compiled shaders : #{useGLShaderName}", :mMenuGLShader],
        ["Apply 2020 makeover  : #{apply2020MakeoverName}", :mMenuApply2020Makeover],
        ["Show FPS             : #{showFpsName}", :mMenuShowFps],
        ["Back", :mMenuDisplayReset, MENU_TOPLEVEL]
      ]

    end
  end

  def mMenu(index)
    @m_menuSet[index]
  end

  def mWaitForAxisKey(which)
    @m_axisKeyWait = which
  end

  def mWaitForKey(which)
    @m_keyWait = which
  end
end
