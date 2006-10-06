#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisTextureLibrary.rb
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
#%Header } avqCjn1AV8PsFQvoiWGwNA
# $Id: AdanaxisTextureLibrary.rb,v 1.17 2006/10/05 15:39:16 southa Exp $
# $Log: AdanaxisTextureLibrary.rb,v $
# Revision 1.17  2006/10/05 15:39:16  southa
# Explosion handling
#
# Revision 1.16  2006/08/01 17:21:18  southa
# River demo
#
# Revision 1.15  2006/08/01 13:41:13  southa
# Pre-release updates
#

class AdanaxisTextureLibrary < MushObject
  def initialize(inParams = {})
  
  end

  def mExplo1Names
    @m_explo1Names
  end

  def mCreate
    levelOfDetail = MushGame.cTextureDetail
    # level 0 and 1 activate OpenGL compression, so 2 uses the same sizes
    # as 1 but without compression
    levelOfDetail += 1 if levelOfDetail < 2
    textureSize = 256 * (2 ** levelOfDetail);
    smallTextureSize = 128 * (2 ** levelOfDetail);
    largeTextureSize = 512 * (2 ** levelOfDetail);
    starTextureSize = 32 * (2 ** levelOfDetail)
    flareTextureSize = smallTextureSize

	# Standard palettes
	MushGLTexture::cDefine(
		:name          => 'palette1',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/palette1.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

	MushGLTexture::cDefine(
		:name          => 'palette2',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/palette2.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

	MushGLTexture::cDefine(
		:name          => 'worldpalette1',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/worldpalette1.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

	MushGLTexture::cDefine(
		:name          => 'riverpalette1',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/riverpalette1.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

	MushGLTexture::cDefine(
		:name          => 'gridpalette1',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/gridpalette1.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

	MushGLTexture::cDefine(
		:name          => 'flarepalette1',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/flarepalette1.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

	MushGLTexture::cDefine(
		:name          => 'emberpalette1',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/emberpalette1.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

	MushGLTexture::cDefine(
		:name          => 'starpalette1',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/starpalette1.tiff',
		:storagetype   => 'U8',
		:cache         => 0
	)

  @m_explo1Names = []
  100.times do |i|
    filename = MushConfig.cGlobalPixelsPath+"/copyright-explo1-#{i}.tiff"
    if File.file?(filename)
      texName = "explo1-tex-#{i}"
      @m_explo1Names << texName
      MushGLTexture::cDefine(
        :name          => texName,
        :type          => 'TIFF',
        :filename      => filename,
        :storagetype   => 'GL',
        :cache         => 0
      )
    end
  end

  scale = 1.4

	MushGLTexture::cDefine(
		:name          => 'attendant-tex',
    :type          => 'CellNoise',
    :meshname      => 'attendant',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1
	)
	
	scale = 4
	
	MushGLTexture::cDefine(
		:name          => 'projectile-tex',
    :type          => 'CellNoise',
    :meshname      => 'projectile',
    :size          => [smallTextureSize, smallTextureSize],
    :palette       => 'palette2',
    :palettestart  => [0.2,0.2],
    :palettevector => [0.8,0.8],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1
	)

  scale = 0.01
	MushGLTexture::cDefine(
		:name          => 'world1-tex',
    :type          => 'CellNoise',
    :meshname      => 'world1',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'worldpalette1',
    :palettestart  => [0,0],
    :palettevector => [0.1,0.1],
		:scale         => [scale,scale,scale,scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1
	)
    
  scale = 0.02
	MushGLTexture::cDefine(
		:name          => 'world2-tex',
    :type          => 'CellNoise',
    :meshname      => 'world1',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'worldpalette1',
    :palettestart  => [0,0],
    :palettevector => [1,1],
		:scale         => [scale,scale,scale,scale],
    :numoctaves    => 4,
    :octaveratio   => 1,
		:cache         => 1
	)

  scale = 1
	MushGLTexture::cDefine(
		:name          => 'river1-tex',
    :type          => 'CellNoise',
    :meshname      => 'river1',
    :size          => [textureSize, textureSize],
    :palette       => 'riverpalette1',
    :palettestart  => [0.01, 0.75],
    :palettevector => [0.98, 0],
		:scale         => [scale,scale,scale,scale],
    :numoctaves    => 4,
    :octaveratio   => 0.5,
		:cache         => 1
	)

  scale = 1
	MushGLTexture::cDefine(
		:name          => 'ground1-tex',
    :type          => 'CellNoise',
    :meshname      => 'ground1',
    :size          => [textureSize, textureSize],
    :palette       => 'riverpalette1',
    :palettestart  => [0.01, 0.25],
    :palettevector => [0.98, 0],
		:scale         => [scale,scale,scale,scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1
	)

  scale = 1
	MushGLTexture::cDefine(
		:name          => 'block1-tex',
    :type          => 'CellNoise',
    :meshname      => 'block1',
    :size          => [textureSize, textureSize],
    :palette       => 'riverpalette1',
    :palettestart  => [0.01, 0.75],
    :palettevector => [0.98, 0],
		:scale         => [scale,scale,scale,scale],
    :numoctaves    => 4,
    :octaveratio   => 0.5,
		:cache         => 1
	)

  scale = 1
  
  10.times do |i|
    MushGLTexture::cDefine(
      :name          => "star#{i}-tex",
      :type          => 'Radial',
      :meshname      => "star#{i}",
      :size          => [starTextureSize, starTextureSize],
      :palette       => 'starpalette1',
      :palettestart  => [0,0.05+0.09*i],
      :palettevector => [0.99,0],
      :scale         => [scale,scale,scale,scale],
      :numoctaves    => 1,
      :octaveratio   => 1,
      :cache         => 0
    )
  end

  10.times do |i|
    MushGLTexture::cDefine(
      :name          => "ember#{i}-tex",
      :type          => 'Radial',
      :meshname      => "ember#{i}",
      :size          => [starTextureSize, starTextureSize],
      :palette       => 'emberpalette1',
      :palettestart  => [0,0.05+0.09*i],
      :palettevector => [0.99,0],
      :scale         => [scale,scale,scale,scale],
      :numoctaves    => 1,
      :octaveratio   => 1,
      :cache         => 1
    )
  end

  10.times do |i|
    MushGLTexture::cDefine(
      :name          => "flare#{i}-tex",
      :type          => 'Radial',
      :meshname      => "flare#{i}",
      :size          => [flareTextureSize, flareTextureSize],
      :palette       => 'flarepalette1',
      :palettestart  => [0,0.05+0.09*i],
      :palettevector => [0.99,0],
      :scale         => [scale,scale,scale,scale],
      :numoctaves    => 1,
      :octaveratio   => 1,
      :cache         => 1
    )

  end


  gridScale = 1;
	gridScaleVec = [gridScale, gridScale, gridScale, gridScale];
	gridRatio = [0.05,0.05,0.05,0.05]
    gridSharpness = 1.00;
	gridSharpnessVec = [gridSharpness, gridSharpness, gridSharpness, gridSharpness];
    gridPaletteStart = [0,0.5]

	MushGLTexture::cDefine(
		:name          => 'grid-tex',
    :type          => 'Grid',
    :meshname      => 'attendant',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'gridpalette1',
    :palettestart  => gridPaletteStart,
    :palettevector => [0.98,0],
		:scale         => gridScaleVec,
    :offset        => [0.07,0.07,0.07,0.07],
    :gridratio     => gridRatio,
    :gridsharpness => gridSharpnessVec,
		:cache         => 1
	)

  end
end
	
