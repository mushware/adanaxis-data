#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushGame.rb
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
#%Header } xpE5oIIXLwKou1xEfvZQKg
# $Id: MushGame.rb,v 1.7 2007/03/13 21:45:02 southa Exp $
# $Log: MushGame.rb,v $
# Revision 1.7  2007/03/13 21:45:02  southa
# Release process
#
# Revision 1.6  2007/03/09 11:29:11  southa
# Game end actions
#
# Revision 1.5  2006/11/08 18:30:53  southa
# Key and axis configuration
#
# Revision 1.4  2006/08/01 17:21:12  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:07  southa
# Pre-release updates
#

class MushGame < MushObject
  GAMERESULT_INVALID=0
  GAMERESULT_NONE=1
  GAMERESULT_DEAD=2
  GAMERESULT_LOST=3
  GAMERESULT_WON=4

# Class: MushGame
#
# Description:
#
# This object supplies a number of utility functions used to control the underlying
# game.
#
# Method: cKeySymbolsToName
#
# Provide the name string corresponding to a key value or values.  
#
# Parameters:
#
# key value - Key value - one or an array of the key values from MushKeys.
#
# Returns:
#
# String containing a name for the key.
#
# Method: cGameModeEnter
#
# Exits menu mode and enters game mode.  Used to resume the game after using the menu.
#
# Parameters:
#
# None.
#
# Returns:
#
# None.
#
# Method: cNewGameEnter
#
# Exits menu mode and enters game mode, discarding the current game and creating a new one.
#
# Parameters:
#
# None.
#
# Returns:
#
# None.
#
# Method: cQuit
#
# Quits the application.
#
# Parameters:
#
# None.
#
# Returns:
#
# None.
#
# Method: cAxisKeySymbol
#
# Parameters:
#
# axis number - Axis key number.
#
# Returns:
#
# Key symbol value (a MushKeys constant) configured for that axis.
#
# Method: cAxisKeySet
#
# Sets the configured key for an axis.
#
# Parameters:
#
# key value - Key symbol value.
# axis number - Axis key number.
#
# Returns:
#
# None.
#
# Method: cAxisSymbol
#
# Returns the configured control axis (e.g. joystick x) for a player axis (e.g. left/right).
#
# Parameters:
#
# axis number - Axis number.
#
# Returns:
#
# Axis symbol value configured for the supplied axis number.
#
# Method: cAxisSet
#
# Sets the configured axis for an axis number.
#
# Parameters:
#
# axis symbol - Axis symbol value.
# axis number - Axis number.
#
# Returns:
#
# None.
#
# Method: cAxisName
#
# Returns the name for an axis symbol.
#
# Parameters:
#
# axis symbol - Axis symbol value.
#
# Returns:
#
# Name string for that axis.
#
# Method: cKeySymbol
#
# Returns the configured key value for a control key.
#
# Parameters:
#
# key number - Key number.
#
# Returns:
#
# Key symbol value configured for the supplied key number.
#
# Method: cKeySet
#
# Sets the configured key for a key control.
#
# Parameters:
#
# key symbol - Key symbol value.
# key number - Key number.
#
# Returns:
#
# None.
#
# Method: cNumJoysticks
#
# Returns the number of joysticks connected to the system.
#
# Parameters:
#
# None.
#
# Returns:
#
# Number of joysticks.
#
# Method: cControlsToDefaultSet
#
# Reloads the default control configuration.
#
# Parameters:
#
# None.
#
# Returns:
#
# None.
#
# Method: cDisplayModeString
#
# Returns a string describing the the current display mode.
#
# Parameters:
#
# None.
#
# Returns:
#
# A string usable to display the mode details, e.g. '640x480 window'.
#
# Method: cPreviousDisplayMode
#
# Change to the previous display mode number.
#
# Parameters:
#
# None.
#
# Returns:
#
# None.
#
# Method: cNextDisplayMode
#
# Change to the next display mode number.
#
# Parameters:
#
# None.
#
# Returns:
#
# None.
#
# Method: cDisplayReset
#
# Resets the display, using a newly configured mode if necessary.
#
# Parameters:
#
# None.
#
# Returns:
#
# None.
#
# Method: cAudioVolume
#
# Reader for the configured audio volume.
#
# Parameters:
#
# None.
#
# Returns:
#
# Volume, range 0..100.
#
# Method: cAudioVolumeSet
#
# Writer for the configured audio volume.
#
# Parameters:
#
# volume - New volume, range 0..100.
#
# Returns:
#
# None.
#
# Method: cMusicVolume
#
# Reader for the configured music volume.
#
# Parameters:
#
# None.
#
# Returns:
#
# Volume, range 0..100.
#
# Method: cMusicVolumeSet
#
# Writer for the configured music volume.
#
# Parameters:
#
# volume - New volume, range 0..100.
#
# Returns:
#
# None.
#
# Method: cVoiceVolume
#
# Reader for the configured voice volume.
#
# Parameters:
#
# None.
#
# Returns:
#
# Volume, range 0..100.
#
# Method: cVoiceVolumeSet
#
# Writer for the configured voice volume.
#
# Parameters:
#
# volume - New volume, range 0..100.
#
# Returns:
#
# None.
#
# Method: cTextureDetail
#
# Reader for the configured texture detail.
#
# Parameters:
#
# None.
#
# Returns:
#
# Texture detail, range 0..4.
#
# Method: cTextureDetailSet
#
# Writer for the configured texture detail.
#
# Parameters:
#
# detail - New texture detail, range 0..4
#
# Returns:
#
# None.
#
# Method: cMouseSensitivity
#
# Reader for the configured mouse sensitivity.
#
# Parameters:
#
# None.
#
# Returns:
#
# Configured mouse sensitivity., range -10.0 .. 10.0.
#
# Method: cMouseSensitivitySet
#
# Writer for the configured mouse sensitivity.
#
# Parameters:
#
# sensitivity - New texture detail, range -10.0 .. 10.0
#
# Returns:
#
# None.
#
# Method: cBrightness
#
# Reader for the configured brightness.
#
# Parameters:
#
# None.
#
# Returns:
#
# Configured brightness, range 0..2.0.
#
# Method: cBrightnessSet
#
# Writer for the configured brightness.
#
# Parameters:
#
# brightness - New brightness, range 0..2.0
#
# Returns:
#
# None.
#
# Method: cGameDialoguesLoad
#
# Loads a game dialogues file from the specified filename.
#
# Parameters:
#
# filename - full filename of game dialogues file
#
# Returns:
#
# None.
#
# Method: cNamedDialoguesAdd
#
# Adds named dialogues to thse currently showing.
#
# Parameters:
#
# names - regular expression used to select dialogues by name
#
# Returns:
#
# None.
#
# Method: cSoundDefine
#
# Associates a sound name with a filename.
#
# Parameters:
#
# name - name of sound
# filename - full filename of sound file (e.g. WAV)
#
# Returns:
#
# None.
#
# Method: cSoundStreamDefine
#
# Associates a sound stream name with a filename.
#
# Parameters:
#
# name - name of sound stream
# filename - full filename of streamable sound file (e.g. OGG)
#
# Returns:
#
# None.
#
# Method: cPackageID
#
# Returns the ID string of the package.
#
# Parameters:
#
# None.
#
# Returns:
#
# Package ID string.
#
# Group: Links
#- Wrapper file:doxygen/class_mush_game_ruby.html
end
