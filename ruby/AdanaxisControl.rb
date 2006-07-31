require 'Mushware.rb'

class AdanaxisControl
  AXISKEY_X_MINUS     = 0
  AXISKEY_X_PLUS      = 1
  AXISKEY_X_REQUIRED  = 2
  AXISKEY_Y_MINUS     = 4
  AXISKEY_Y_PLUS      = 5
  AXISKEY_Y_REQUIRED  = 6
  AXISKEY_Z_MINUS     = 8
  AXISKEY_Z_PLUS      = 9
  AXISKEY_Z_REQUIRED  = 10
  AXISKEY_W_MINUS     = 12
  AXISKEY_W_PLUS      = 13
  AXISKEY_W_REQUIRED  = 14


  AXISKEY_XY_MINUS    = 16
  AXISKEY_XY_PLUS     = 17
  AXISKEY_XY_REQUIRED = 18
  
  AXISKEY_ZW_MINUS    = 20
  AXISKEY_ZW_PLUS     = 21
  AXISKEY_ZW_REQUIRED = 22
  
  AXISKEY_XZ_MINUS    = 24
  AXISKEY_XZ_PLUS     = 25
  AXISKEY_XZ_REQUIRED = 26
  
  AXISKEY_YW_MINUS    = 28
  AXISKEY_YW_PLUS     = 29
  AXISKEY_YW_REQUIRED = 30
  
  AXISKEY_XW_MINUS    = 32
  AXISKEY_XW_PLUS     = 33
  AXISKEY_XW_REQUIRED = 34

  AXISKEY_YZ_MINUS    = 36
  AXISKEY_YZ_PLUS     = 37
  AXISKEY_YZ_REQUIRED = 38

  AXIS_X = 0
  AXIS_Y = 1
  AXIS_Z = 2
  AXIS_W = 3
  AXIS_XY = 4
  AXIS_ZW = 5
  AXIS_XZ = 6
  AXIS_YW = 7
  AXIS_XW = 8
  AXIS_YZ = 9

  KEY_FIRE = 0
  KEY_SCANNER = 1

  INAXIS_NONE = 0
  INAXIS_MOUSE_X = 16
  INAXIS_MOUSE_Y = 17
  INAXIS_MOUSE2_X = 32
  INAXIS_MOUSE2_Y = 33
  INAXIS_STICK_X = 48
  INAXIS_STICK_Y = 49
  INAXIS_STICK_Z = 50
  INAXIS_STICK_W = 51
  INAXIS_STICK_5 = 52
  INAXIS_STICK_6 = 53
  INAXIS_STICK2_X = 64
  INAXIS_STICK2_Y = 65
  INAXIS_STICK2_Z = 66
  INAXIS_STICK2_W = 67
  INAXIS_STICK2_5 = 68
  INAXIS_STICK2_6 = 69

  def initialize
  end

  def self.cAxisKeyName(axisKey)
    MushGame.cKeySymbolToName( MushGame.cAxisKeySymbol(axisKey) )
  end

  def self.cAxisName(axisNum)
    MushGame.cAxisName( MushGame.cAxisSymbol(axisNum) );
  end

  def self.cKeyName(keyNum)
    MushGame.cKeySymbolToName( MushGame.cKeySymbol(keyNum) )
  end

  def self.cNextAxis(inAxis)
    numSticks = MushGame.cNumJoysticks
    axisProg = [INAXIS_NONE, INAXIS_MOUSE_X, INAXIS_MOUSE_Y]
    if numSticks > 0
      axisProg += [INAXIS_STICK_X, INAXIS_STICK_Y, INAXIS_STICK_Z, INAXIS_STICK_W, INAXIS_STICK_5, INAXIS_STICK_6]
    end
    if numSticks > 1
      axisProg += [INAXIS_STICK2_X, INAXIS_STICK2_Y, INAXIS_STICK2_Z, INAXIS_STICK2_W, INAXIS_STICK2_5, INAXIS_STICK2_6]
    end

    pos = axisProg.index(inAxis) || 0
    pos = (pos + 1) % axisProg.size
    axisProg[pos]
  end

end
