
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
# extent - size of each tile [x, y]
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
#   :extent => [337.0/8, 768.0/12]
# )
# (end)
#
# Group: Links
#- Wrapper file:doxygen/class_mush_g_l_ruby_font.html
#- Implemetation file:doxygen/class_mush_g_l_font.html
end
