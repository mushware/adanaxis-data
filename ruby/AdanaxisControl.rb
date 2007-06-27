#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisControl.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } fCKaGUAeHXb6sG0R4aZGMQ
# $Id: AdanaxisControl.rb,v 1.11 2007/04/18 09:21:52 southa Exp $
# $Log: AdanaxisControl.rb,v $
# Revision 1.11  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.10  2007/04/16 08:41:05  southa
# Level and header mods
#
# Revision 1.9  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.8  2006/11/08 18:30:53  southa
# Key and axis configuration
#
# Revision 1.7  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.6  2006/08/01 17:21:17  southa
# River demo
#
# Revision 1.5  2006/08/01 13:41:11  southa
# Pre-release updates
#

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
  KEY_WEAPON_PREVIOUS = 2
  KEY_WEAPON_NEXT = 3
  KEY_WEAPON_0 = 4
  KEY_WEAPON_1 = 5
  KEY_WEAPON_2 = 6
  KEY_WEAPON_3 = 7
  KEY_WEAPON_4 = 8
  KEY_WEAPON_5 = 9
  KEY_WEAPON_6 = 10
  KEY_WEAPON_7 = 11
  KEY_WEAPON_8 = 12
  KEY_WEAPON_9 = 13

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
    MushGame.cKeySymbolsToName( MushGame.cAxisKeySymbols(axisKey) )
  end

  def self.cAxisName(axisNum)
    MushGame.cAxisName( MushGame.cAxisSymbol(axisNum) );
  end

  def self.cKeyName(keyNum)
    MushGame.cKeySymbolsToName( MushGame.cKeySymbols(keyNum) )
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
