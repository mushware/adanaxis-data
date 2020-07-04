#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushShaderLibrary.rb
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
#%Header } tqhkm2Wudb9Q1otb8xFFLw
# $Id: MushShaderLibrary.rb,v 1.1 2006/09/10 10:30:51 southa Exp $
# $Log

class MushShaderLibrary < MushObject

#
# Default 4D vertex shader
#
  def self.cVertex4D
    <<EOS
// Standard 4D vertex shader

uniform vec4 mush_ProjectionOffset;
uniform vec4 mush_ModelViewOffset;
uniform vec4 mush_ModelViewProjectionOffset;
uniform float mush_FValue;

varying float mush_ZDiscrim;

void main(void)
{
    gl_TexCoord[0] = gl_MultiTexCoord0;
    
    vec4 eyePos = mush_ModelViewOffset + gl_ModelViewMatrix * gl_Vertex;
    
    if (eyePos.w >= 0.0)
    {
        mush_ZDiscrim = -eyePos.z * mush_FValue / eyePos.w;
    }
    else
    {
        mush_ZDiscrim = eyePos.z * mush_FValue / eyePos.w;
    }
    
    gl_Position = mush_ModelViewProjectionOffset + gl_ModelViewProjectionMatrix * gl_Vertex;
}
EOS
  end

#
# Default 4D fragment shader
#
  def self.cFragment4D
    <<EOS
// Standard 4D fragment shader

uniform vec4 mush_Colour0;
uniform vec4 mush_Colour1;
uniform vec4 mush_Colour2;

varying float mush_ZDiscrim;

uniform sampler2D tex;

void main(void)
{
    vec4 texColor = texture2D(tex, gl_TexCoord[0].st);
    vec4 hintColour;    
    if (mush_ZDiscrim < 0.0)
    {
        hintColour = mix(mush_Colour1, mush_Colour0, -mush_ZDiscrim);
    }
    else
    {
        hintColour = mix(mush_Colour1, mush_Colour2, mush_ZDiscrim);
    }
    gl_FragColor = texColor * hintColour;
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
      :vertex_shader => cVertex4D,
      :fragment_shader => cFragment4D
    )
  end
  
  def self.cCreate
    cStandardCreate
  end
end
