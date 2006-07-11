
require 'AdanaxisControl.rb'

class AdanaxisMenu
  MENU_TOPLEVEL = 0
  MENU_CONTROL = 1
  MENU_KEYS = 2
  MENU_MOUSE = 3
  MENU_JOYSTICK = 4
  
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
            ["New Game", :mMenuNewGame],
            ["Controls", :mToMenu, MENU_CONTROL],
            ["Options", :mMenuOptions],
            ["Quit", :mMenuQuit]
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
    
    @menuSet = [
      @topLevelMenu,
      @controlMenu,
      @keysMenu,
      @mouseMenu,
      @joystickMenu
    ]
    @axisKeyWait = nil
    @keyWait = nil
  end
  
  attr_reader :axisKeyWait, :keyWait
  
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
  
  def mUpdate(menu)
    if menu == MENU_KEYS
      @menuSet[MENU_KEYS].menu = [  
        mAxisKeyMenuEntry("Dodge left        : ", AdanaxisControl::AXISKEY_X_MINUS),
        mAxisKeyMenuEntry("Dodge right       : ", AdanaxisControl::AXISKEY_X_PLUS),
        mAxisKeyMenuEntry("Forward           : ", AdanaxisControl::AXISKEY_W_MINUS),
        mAxisKeyMenuEntry("Backward          : ", AdanaxisControl::AXISKEY_W_PLUS),
        mKeyMenuEntry(    "Fire              : ", AdanaxisControl::KEY_FIRE),
        mKeyMenuEntry(    "Scanner           : ", AdanaxisControl::KEY_SCANNER),
        ["Use default"],
        ["Advanced keys"],
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
        ["Use default"],
        ["Advanced axes"],
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
        ["Use default"],
        ["Advanced axes"],
        ["Back", :mMenuBack, MENU_CONTROL]
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
