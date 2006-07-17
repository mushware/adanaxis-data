
class AdanaxisTextureLibrary < MushObject
  def self.cCreate
    levelOfDetail=2
    textureSize = 256 * (2 ** levelOfDetail);
    smallTextureSize = 128 * (2 ** levelOfDetail);
    largeTextureSize = 512 * (2 ** levelOfDetail);

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



	scale = 0.3

	MushGLTexture::cDefine(
		:name          => 'attendant-tex',
        :type          => 'CellNoise',
        :meshname      => 'attendant',
        :size          => [textureSize, textureSize],
        :palette       => 'palette1',
        :palettestart  => [0,0],
        :palettevector => [1.0,1.0],
		:scale         => [scale, scale, scale, scale],
        :numoctaves    => 8,
        :octaveratio   => 0.5,
		:cache         => 0
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

    gridScale = 2.7;
	gridScaleVec = [gridScale, gridScale, gridScale, gridScale];
	gridRatio = [0.1,0.1,0.1,0.1]
    gridSharpness = 1.0;
	gridSharpnessVec = [gridSharpness, gridSharpness, gridSharpness, gridSharpness];
    gridPaletteStart = [0,0.5]

	MushGLTexture::cDefine(
		:name          => 'grid-tex',
        :type          => 'Grid',
        :meshname      => 'projectile',
        :size          => [textureSize, textureSize],
        :palette       => 'gridpalette1',
        :palettestart  => gridPaletteStart,
        :palettevector => [0.98,0],
		:scale         => gridScaleVec,
        :offset        => [0.05,0.05,0.05,0.05],
        :gridratio     => gridRatio,
        :gridsharpness => gridSharpnessVec,
		:cache         => 1
	)

  end
end
	