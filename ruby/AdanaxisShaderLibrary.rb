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
# $Id$
# $Log$

class AdanaxisShaderLibrary < MushObject
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
    cTestCreate
  end
end
