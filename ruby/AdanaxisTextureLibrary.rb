
class AdanaxisTextureLibrary < MushObject
  def self.cCreate
    levelOfDetail = MushGame.cTextureDetail
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
	