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

