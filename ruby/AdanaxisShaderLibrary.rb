#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisShaderLibrary.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } TdNUOwKtoKPRBQwBNPKiRw
# $Id: AdanaxisShaderLibrary.rb,v 1.1 2006/09/07 10:02:36 southa Exp $
# $Log: AdanaxisShaderLibrary.rb,v $
# Revision 1.1  2006/09/07 10:02:36  southa
# Shader interface
#

class AdanaxisShaderLibrary < MushObject

#
# Default 4D vertex shader
#
  def self.cVertex4D
    <<EOS
// Default vertex shader

uniform vec4 mush_ProjectionOffset;
uniform vec4 mush_ModelViewOffset;
uniform vec4 mush_ModelViewProjectionOffset;

// varying vec4 mush_EyePosition;

void main(void)
{
    gl_FrontColor = gl_Color;
    gl_TexCoord[0] = gl_MultiTexCoord0;
    
    // mush_EyePosition = mush_ModelViewOffset + gl_ModelViewMatrix * gl_Vertex;
    gl_Position = mush_ModelViewProjectionOffset + gl_ModelViewProjectionMatrix * gl_Vertex;
}
EOS
  end

#
# Standard shader definitions
#
  def self.cStandardCreate
    # Standard OpenGL pipeline
    MushGLShader.new(
      :name => 'standard'
    )
    
    shader = MushGLShader.new(
      :name => 'project4d',
      :vertex_shader => cVertex4D
    )
  end
  
  def self.cTestCreate
  
    fragmentShader = <<EOS
   
// Default fragment shader

uniform sampler2D tex;

void main(void)
{
		vec4 color = texture2D(tex,gl_TexCoord[0].st);
    gl_FragColor = color * gl_Color;
}

EOS

    vertexShader =  <<EOS

// Default vertex shader

void main(void)
{
    gl_FrontColor = gl_Color;
    gl_BackColor = gl_Color;
    gl_TexCoord[0] = gl_MultiTexCoord0;
    gl_Position = ftransform();
}

EOS

    shader = MushGLShader.new(
      :name => 'testshader1',
      :fragment_shader => fragmentShader,
      :vertex_shader => vertexShader
    )
  end

  def self.cCreate
    cStandardCreate
    cTestCreate
  end
end
