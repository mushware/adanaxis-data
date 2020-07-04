#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushGLFont.rb
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
#%Header } unm8nDyAaIKThRJGaQ0fdQ
# $Id: MushGLFont.rb,v 1.4 2006/08/01 17:21:12 southa Exp $
# $Log: MushGLFont.rb,v $
# Revision 1.4  2006/08/01 17:21:12  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:06  southa
# Pre-release updates
#

class MushGLFont
# Class: MushGLFont
#
# Description:
#
# This object creates or contains a reference to a renderable font.
#
# Method: new
#
# Creates a new MushGLFont object.  
#
# Parameters:
#
# name - name for this font
# texture_name - name of the texture used by this font
# divide - number of tiles in the font in the [x, y] directions
# extent - size of each tile [x, y] in pixels
# size - size of each character [x, y] or x, with 1.0 filling the screen with one character
#
# Parameters mush be suppliead as a hash.
#
# Returns:
#
# New MushGLFont object
#
# Default:
#
# There is no default constructor.  If only the name is supplied, this object refers
# to a pre-existing font.
#
# Example:
#
# (example)
# MushGLTexture::cDefine(
#	:name          => 'font1-tex',
#   :type          => 'TIFF',
#	:filename      => 'font-mono1.tiff'
# )
# 
# font1 = MushGLFont.new(
#   :name => 'font1',
#   :texture_name => 'font1-tex',
#   :divide => [8,12],
#   :extent => [337.0/8, 768.0/12],
#   :size => 0.05
# )
# (end)
#
# Group: Links
#- Wrapper file:doxygen/class_mush_g_l_ruby_font.html
#- Implemetation file:doxygen/class_mush_g_l_font.html
end
