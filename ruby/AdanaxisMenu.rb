#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisMenu.rb
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
#%Header } jugTbpTzFS8mdBHUZaOpuw
# $Id: AdanaxisMenu.rb,v 1.12 2006/08/01 13:41:12 southa Exp $
# $Log: AdanaxisMenu.rb,v $
# Revision 1.12  2006/08/01 13:41:12  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'AdanaxisControl.rb'

class AdanaxisMenu
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
    @menuCommon = {
      :size => 0.02,
      :colour => MushVector.new(0.7,0.7,1,0.7),
      :title_colour => MushVector.new(1,1,1,0.7)
    }
    
    @topLevelMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Adanaxis",
          :menu => [  
            ["(Requires update)", :mResume],
            ["Back", :mMenuBack]
          ]
        }
      )
    )
    
    @controlMenu = MushMenu.new(
      @menuCommon.merge(
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
    
    @keysMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Key Controls",
          :menu => [  
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )
    
    @mouseMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Mouse Control",
          :menu => [  
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )
    
    @joystickMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Joystick Control",
          :menu => [  
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )
    
        
    @advAxesMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Advanced Axes",
          :menu => [  
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )
    
    @advKeysMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Advanced Keys",
          :menu => [  
            ["(Requires update)", :mMenuBack, MENU_KEYS],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @chooseLevelMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Choose level",
          :menu => [  
            ["(Requires update)", :mMenuBack, MENU_TOPLEVEL],
            ["Back", :mMenuBack]
          ]
        }
      )
    )

    @optionsMenu = MushMenu.new(
      @menuCommon.merge(
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

    
    @menuSet = [
      @topLevelMenu,
      @controlMenu,
      @keysMenu,
      @mouseMenu,
      @joystickMenu,
      @advAxesMenu,
      @advKeysMenu,
      @chooseLevelMenu,
      @optionsMenu
    ]
    @axisKeyWait = nil
    @keyWait = nil
    @allowResume = false
  end
  
  attr_reader :axisKeyWait, :keyWait
  attr_accessor :allowResume
  
  def mAxisMenuEntry(name, which)
    [ name+AdanaxisControl.cAxisName(which),
      :mMenuAxis,
      which
    ]
  end

  def mAxisKeyMenuEntry(name, which)
    if @axisKeyWait == which
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
    if @keyWait == which
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
  
  def mNewGameMenuEntry(name, key)
    [ name, :mMenuGameSelect, key.untaint ]
  end
  
  def mReset(menu)
    @menuSet[menu].current = 0
  end
  
  def mUpdateLevels(levelList, showHidden)
    @menuSet[MENU_CHOOSE_LEVEL].menu = []
    levelList.each do |level|
      next if !showHidden && level[AdanaxisLevels::PARAMS]['visibility'] == 'hidden'
      name = level[AdanaxisLevels::PARAMS]['name'] || level[AdanaxisLevels::KEY]
      @menuSet[MENU_CHOOSE_LEVEL].menu.push mNewGameMenuEntry(name, level[AdanaxisLevels::KEY])
    end
    @menuSet[MENU_CHOOSE_LEVEL].menu.push ["Back", :mMenuBack, MENU_TOPLEVEL]
  end
  
  def mUpdate(menu)
    if menu == MENU_TOPLEVEL
        menuArray = [  
              ["New Game", :mToMenu, MENU_CHOOSE_LEVEL],
              ["Controls", :mToMenu, MENU_CONTROL],
              ["Options", :mMenuToOptions],
              ["Quit", :mMenuQuit]
            ]
        if @allowResume
          menuArray.unshift ["Resume", :mMenuResume]
        end
        
        @menuSet[MENU_TOPLEVEL].menu = menuArray
    end

    if menu == MENU_KEYS
      @menuSet[MENU_KEYS].menu = [  
        mAxisKeyMenuEntry("Dodge left        : ", AdanaxisControl::AXISKEY_X_MINUS),
        mAxisKeyMenuEntry("Dodge right       : ", AdanaxisControl::AXISKEY_X_PLUS),
        mAxisKeyMenuEntry("Forward           : ", AdanaxisControl::AXISKEY_W_MINUS),
        mAxisKeyMenuEntry("Backward          : ", AdanaxisControl::AXISKEY_W_PLUS),
        mKeyMenuEntry(    "Fire              : ", AdanaxisControl::KEY_FIRE),
        mKeyMenuEntry(    "Scanner           : ", AdanaxisControl::KEY_SCANNER),
        ["Advanced keys", :mToMenu, MENU_ADV_KEYS],
        ["Back", :mMenuBack, MENU_CONTROL]
      ]
    end
    
    if menu == MENU_MOUSE
      @menuSet[MENU_MOUSE].menu = [  
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
      @menuSet[MENU_JOYSTICK].menu = [
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
      @menuSet[MENU_ADV_AXES].menu = [
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
      @menuSet[MENU_ADV_KEYS].menu = [
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
        when 0: "low"
        when 1: "medium"
        when 2: "high"
        when 3: "very high (>128MB)"
        when 4: "vast (>512MB)"
        else "unknown"
      end
      @menuSet[MENU_OPTIONS].menu = [
        ["Display mode      : "+MushGame.cDisplayModeString, :mMenuDisplayMode],
        ["Audio volume      : #{MushGame.cAudioVolume}%", :mMenuAudioVolume],
        ["Music volume      : #{MushGame.cMusicVolume}%", :mMenuMusicVolume],
        ["Texture detail    : #{detailName}", :mMenuTextureDetail],
        ["Brightness        : #{'%2.2f'%MushGame.cBrightness}", :mMenuBrightness],
        ["Mouse sensitivity : #{'%2.2f'%MushGame.cMouseSensitivity}", :mMenuMouseSensitivity],
        ["Back", :mMenuDisplayReset, MENU_TOPLEVEL]
      ]
      
    end
  end
  
  def mMenu(index)
    @menuSet[index]
  end
  
  def mWaitForAxisKey(which)
    @axisKeyWait = which
  end
  
  def mWaitForKey(which)
    @keyWait = which
  end
end
