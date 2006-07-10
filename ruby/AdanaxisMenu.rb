
require 'AdanaxisControl.rb'

class AdanaxisMenu
  MENU_TOPLEVEL = 0
  MENU_CONTROL = 1
  MENU_KEYS = 2
  MENU_MOUSE = 3

  def initialize
    @menuCommon = {
      :size => 0.018,
      :colour => MushVector.new(0.7,0.7,1,0.7),
      :title_colour => MushVector.new(1,1,1,0.7)
    }
    
    @topLevelMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Adanaxis",
          :menu => [  
            ["New Game", :mMenuNewGame],
            ["Controls", :mMenuControls],
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
            ["Keys", :mMenuKeys],
            ["Mouse/Joystick", :mMenuMouse],
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
            ["(Requires update)", :mMenuBack],
            ["Back", :mMenuBack]
          ]
        }
      )
    )
    
    @mouseMenu = MushMenu.new(
      @menuCommon.merge(
        {
          :title => "Mouse and Joystick Controls",
          :menu => [  
            ["(Requires update)", :mMenuBack],
            ["Back", :mMenuBack]
          ]
        }
      )
    )
    
    @menuSet = [
      @topLevelMenu,
      @controlMenu,
      @keysMenu,
      @mouseMenu
    ]
    
  end
  
  def mUpdate(menu)
    if menu == MENU_KEYS
      @menuSet[MENU_KEYS].menu = [  
        ["Dodge left        : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_X_MINUS), :mMenuKey],
        ["Dodge right       : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_X_PLUS), :mMenuKey],
        ["Forward           : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_W_PLUS), :mMenuKey],
        ["Backward          : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_W_MINUS), :mMenuKey],
        ["Fire              : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_ZW_REQUIRED), :mMenuKey],
        ["Advanced keys"],
        ["Back", :mMenuBack]
      ]
    end
    
    if menu == MENU_MOUSE
      @menuSet[MENU_MOUSE].menu = [  
        ["Aim left/right        : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_XW_MINUS), :mMenuKey],
        [" - only with keypress : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_X_PLUS), :mMenuKey],
        ["Aim up/down           : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_W_PLUS), :mMenuKey],
        [" - only with keypress : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_W_MINUS), :mMenuKey],
        ["Aim in hidden axis    : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_ZW_REQUIRED), :mMenuKey],
        [" - only with keypress : " + AdanaxisControl.cAxisKeyName(AdanaxisControl::AXISKEY_W_MINUS), :mMenuKey],
        ["Advanced axes"],
        ["Back", :mMenuBack]
      ]
    end

  end
  
  
  def mMenu(index)
    @menuSet[index]
  end
end
