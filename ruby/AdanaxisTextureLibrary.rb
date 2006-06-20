
class AdanaxisTextureLibrary < MushObject
  def self.cCreate
    levelOfDetail=2
    textureSize = 256 * (2 ** levelOfDetail);

	# Standard palettes
	MushGLTexture::cDefine(
		:name          => 'palette1',
        :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/palette1.tiff',
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
		:name          => 'attendant-tex',
        :type          => 'CellNoise',
        :meshname      => 'attendant',
        :size          => [textureSize, textureSize],
        :palette       => 'palette1',
        :palettestart  => [0,0],
        :palettevector => [1.0,1.0],
        :numoctaves    => 8,
        :octaveratio   => 0.5,
		:cache         => 1
	)

    gridScale = 2.7;
	gridScaleVec = [gridScale, gridScale, gridScale, gridScale];
	gridRatio = [0.1,0.1,0.1,0.1]
    gridSharpness = 1.0;
	gridSharpnessVec = [gridSharpness, gridSharpness, gridSharpness, gridSharpness];
    gridPaletteStart = [0,0.5]

	MushGLTexture::cDefine(
		:name          => 'tex3',
        :type          => 'Grid',
        :meshname      => 'attendant',
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

	MushGLTexture::cDefine(
		:name          => 'texture',
        :type          => 'TileShow',
		:meshname      => 'attendant',
        :size          => [textureSize, textureSize],
        :palette       => 'gridpalette1',
        :palettestart  => gridPaletteStart,
        :palettevector => [0.98,0],
		:cache         => 1
	)

	# MushGLTexture::cPreCache('texture')
  end
end
	