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
# $Id: AdanaxisTextureLibrary.rb,v 1.28 2006/11/15 19:26:02 southa Exp $
# $Log: AdanaxisTextureLibrary.rb,v $
# Revision 1.28  2006/11/15 19:26:02  southa
# Rail changes
#
# Revision 1.27  2006/11/15 18:25:54  southa
# Khazi rails
#
# Revision 1.26  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.25  2006/11/14 14:02:15  southa
# Ball projectiles
#
# Revision 1.24  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.23  2006/11/07 11:08:54  southa
# Texture loading from mushfiles
#
# Revision 1.22  2006/11/03 18:46:32  southa
# Damage effectors
#
# Revision 1.21  2006/10/19 15:41:35  southa
# Item handling
#
# Revision 1.20  2006/10/18 13:22:08  southa
# World rendering
#
# Revision 1.19  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.18  2006/10/06 14:48:17  southa
# Material animation
#
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
    @m_exploNames = []
  end

  mush_reader :m_exploNames, :m_cosmos1Names

  def mCreate
    levelOfDetail = MushGame.cTextureDetail
    textureSize = 256 * (2 ** levelOfDetail);
    smallTextureSize = 128 * (2 ** levelOfDetail);
    largeTextureSize = 512 * (2 ** levelOfDetail);
    starTextureSize = 32 * (2 ** levelOfDetail)
    flareTextureSize = smallTextureSize

    compressNear = case levelOfDetail
      when 0..1: true
      else false
    end
    
    compressFar = case levelOfDetail
      when 0..3: true
      else false
    end

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
		:name          => 'palette3',
    :type          => 'TIFF',
		:filename      => MushConfig.cGlobalPixelsPath+'/palette3.tiff',
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

  # Boxes
  
  %w{ health shield base lightcannon quadcannon flak
    heavycannon rail lightmissile heavymissile flush nuclear}.each do |name|
    raise("fie #{name}") unless File.file?(MushConfig.cGlobalPixelsPath+"/#{name}box1.tiff")
    MushGLTexture::cDefine(
      :name          => "#{name}box1-tex",
      :type          => 'TIFF',
      :filename      => MushConfig.cGlobalPixelsPath+"/#{name}box1.tiff",
      :storagetype   => 'GL',
      :cache         => 0,
      :compress      => compressFar
    )
  end

  MushGLTexture::cDefine(
    :name          => "ball1-tex",
    :type          => 'TIFF',
    :filename      => MushConfig.cGlobalPixelsPath+'/ball1.tiff',
    :storagetype   => 'GL',
    :cache         => 0,
    :compress      => compressFar
  )

  MushGLTexture::cDefine(
    :name          => "rail1-tex",
    :type          => 'TIFF',
    :filename      => MushConfig.cGlobalPixelsPath+'/rail1.tiff',
    :storagetype   => 'GL',
    :cache         => 0,
    :compress      => compressFar
  )

  @m_explo1Names = []
  maxExplos = case levelOfDetail
    when 0: 2
    when 1: 4
    else 8
  end
  
  maxExplos.times do |exploNum|
    @m_exploNames << []
    100.times do |i|
      filename = "mush://pixels/artb-explo#{exploNum}-#{i}.tiff|#{MushConfig.cGlobalPixelsPath}/explo#{exploNum}-#{i}.tiff"
      if MushFile.cFile?(filename)
        texName = "explo#{exploNum}-tex-#{i}"
        @m_exploNames[exploNum] << texName
        MushGLTexture::cDefine(
          :name          => texName,
          :type          => 'TIFF',
          :filename      => filename,
          :storagetype   => 'GL',
          :cache         => 0,
          :compress      => compressFar
        )
      end
    end
  end

  @m_cosmos1Names = []
  100.times do |i|
    filename = MushConfig.cGlobalPixelsPath+"/cosmos/cosmos1-#{i}.tiff"
    if File.file?(filename)
      texName = "cosmos1-tex-#{i}"
      @m_cosmos1Names << texName
      MushGLTexture::cDefine(
        :name          => texName,
        :type          => 'TIFF',
        :filename      => filename,
        :storagetype   => 'GL',
        :cache         => 0,
        :compress      => compressFar
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
		:cache         => 1,
    :compress      => compressNear
	)
	
  scale = 0.1
	MushGLTexture::cDefine(
		:name          => 'khazi-rail-tex',
    :type          => 'CellNoise',
    :meshname      => 'khazi-rail',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.5],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.6,
		:cache         => 1,
    :compress      => compressNear
	)

  scale = 1.4

	MushGLTexture::cDefine(
		:name          => 'player-tex',
    :type          => 'CellNoise',
    :meshname      => 'attendant',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.8],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 5,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear
	)
	
	scale = 4
	
	MushGLTexture::cDefine(
		:name          => 'projectile1-tex',
    :type          => 'CellNoise',
    :meshname      => 'projectile1',
    :size          => [smallTextureSize, smallTextureSize],
    :palette       => 'palette2',
    :palettestart  => [0.2,0.2],
    :palettevector => [0.8,0.8],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear
	)

	MushGLTexture::cDefine(
		:name          => 'projectile2-tex',
    :type          => 'CellNoise',
    :meshname      => 'projectile2',
    :size          => [smallTextureSize, smallTextureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.9],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear
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
		:cache         => 1,
    :compress      => compressFar
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
		:cache         => 1,
    :compress      => compressFar
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
		:cache         => 1,
    :compress      => compressNear
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
		:cache         => 1,
    :compress      => compressNear
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
		:cache         => 1,
    :compress      => compressNear
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
      :cache         => 0,
      :compress      => compressFar
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
      :cache         => 1,
      :compress      => compressNear
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
      :cache         => 1,
      :compress      => compressNear
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
		:cache         => 1,
    :compress      => compressNear
	)

  end
end
	
