#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushGLTexture.rb
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
#%Header } juv2MmD6WEUtTDbBxs+RiA
# $Id: MushGLTexture.rb,v 1.5 2007/02/08 17:55:11 southa Exp $
# $Log: MushGLTexture.rb,v $
# Revision 1.5  2007/02/08 17:55:11  southa
# Common routines in space generation
#
# Revision 1.4  2006/08/01 17:21:12  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:07  southa
# Pre-release updates
#

class MushGLTexture
# Class: MushGLTexture
#
# Description:
#
# This object contains and generates texture maps.
#
# Method: cDefine
#
# Defines a new texture.  
#
# Parameters:
#
# Parameters common to all texture types.
# 
# name - Name used to refer to the texture
# type - String that determines the class used to handle the texture, and thereby the
# parameters that can be used
# size - size of the texture in pixels
# storagetype - use "U8" if the texture is to be used for palette lookup, otherwise "GL" (the default)
# cache - Whether the texture should be cached or not.  Default is sensible for the type.
#
# Parameters for all skin textures.
#
# meshname - name of the mesh to be skinned
# palette - name of a texture to be used as a colour palette
# palettestart - start uv coordinates for palette lookup
# palettevector - uv vector defining the range of the palette
# scale - vector multiplier used to scale the 4D position before passing the skin function
# offset - vector offset added to the 4D position before passing to the skin function
#
# Parameters for CellNoise types.
#
# numoctaves - Number of octaves of noise, typically 4 to 12
# octaveratio - Amplitude multiplier between octaves, typically 0.5
#
# Parameters for Grid types.
#
# gridratio - vector defining the width 0.0 - 1.0 of the grid lines in each direction
# gridsharpness - vector defining the sharpness 0.0 - 1.0 of the grid lines in each direction
#
# Parameters for Radial types.
#
# Returns:
#
# None.
#
# Example:
#
# (example)
# MushGLTexture::cDefine(
#   :name          => 'attendant-tex',
#   :type          => 'CellNoise',
#   :meshname      => 'attendant',
#   :size          => [512, 512],
#   :palette       => 'palette1',
#   :palettestart  => [0,0.5],
#   :palettevector => [0.99,0],
#   :scale         => [0.1, 0.1, 0.1, 0.1],
#   :numoctaves    => 8,
#   :octaveratio   => 0.5)
# (end)
#
# Method: cPrecache
#
# Loads a texture into memory.  Usually, textures will load when they are first
# used.  This function loads the names textured immediately, prevently a delay
# during gameplay as the texture is loaded or generated.
#
# Parameters:
#
# name - name of the texture as passed to cDefine
#
# Returns:
#
# None.
#
# Example:
#
# (example)
# MushGLTexture::cPrecache('attendant-tex')
# (end)
#
# Group: Links
#- Implemetation file:doxygen/class_mush_g_l_texture.html

  def self.cDefine(paramHash)
    cRubyDefine(paramHash);
  end

  def self.cPrecache(texName)
    cRubyPrecache(texName);
  end
end
