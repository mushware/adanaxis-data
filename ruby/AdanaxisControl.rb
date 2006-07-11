require 'Mushware.rb'

class AdanaxisControl
  AXISKEY_X_MINUS     = 0
  AXISKEY_X_PLUS      = 1
  AXISKEY_Y_MINUS     = 4
  AXISKEY_Y_PLUS      = 5
  AXISKEY_Z_MINUS     = 8
  AXISKEY_Z_PLUS      = 9
  AXISKEY_W_MINUS     = 12
  AXISKEY_W_PLUS      = 13


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

end
