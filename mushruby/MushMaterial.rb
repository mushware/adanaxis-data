#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushMaterial.rb
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
#%Header } ZgBPJ9ae/CTrVb/Nvm4jsQ
# $Id: MushMaterial.rb,v 1.3 2006/08/01 17:21:13 southa Exp $
# $Log: MushMaterial.rb,v $
# Revision 1.3  2006/08/01 17:21:13  southa
# River demo
#
# Revision 1.2  2006/08/01 13:41:07  southa
# Pre-release updates
#

class MushMaterial
# Class: MushMaterial
#
# Description:
#
# This object describes the material used to render a mesh.  Typically it
# just names the texture to be used.
#
# Example:
#
# (example)
# MushGLTexture.cDefine(
#    :name          => 'texture1',
#    :type          => 'TIFF',
#    :filename      => MushConfig.GlobalPixelsPath+'/texturefile1.tiff'
#	)
# MushMaterial.cDefine(
#     :name => 'material1',
#     :texture_name => 'texture1'
# )
#  ...
# mesh.mAddMaterial('material1')
# (end)
#
# Method: cDefine
#
# Defines a material, adding it to the global database.  It can then be used
# by adding it to a <MushMesh> object.
#
# Parameters:
#
# name - Name used to refer to this material
# texture_name - name of the texture used by this material
#
# Method: to_xml
#
# Returns XML for the entire material database.  This is a singeton method.
#
# (example)
# puts MushMaterial.to_xml
# (end)
#
# Parameters:
#
# None.
#
# Returns:
#
# A string containing the XML.
#
# Group: Links
#- Wrapper and implementation file:doxygen/class_mush_g_l_material.html

  def self.cDefine(params)
    cRubyDefine(params)
  end
  
  def self.to_xml
    cRubyto_xml()
  end	
end

