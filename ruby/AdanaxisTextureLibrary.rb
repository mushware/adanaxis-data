#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisTextureLibrary.rb
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
#%Header } bZGHQwvorFzAHNCPBFd1/g
# $Id: AdanaxisTextureLibrary.rb,v 1.53 2007/06/27 12:58:12 southa Exp $
# $Log: AdanaxisTextureLibrary.rb,v $
# Revision 1.53  2007/06/27 12:58:12  southa
# Debian packaging
#
# Revision 1.52  2007/06/14 12:14:15  southa
# Level 30
#
# Revision 1.51  2007/06/08 16:23:03  southa
# Level 26
#
# Revision 1.50  2007/06/06 12:24:13  southa
# Level 22
#
# Revision 1.49  2007/05/23 19:14:58  southa
# Level 18
#
# Revision 1.48  2007/05/22 16:44:58  southa
# Level 18
#
# Revision 1.47  2007/05/10 11:44:12  southa
# Level15
#
# Revision 1.46  2007/05/08 15:28:14  southa
# Level 12
#
# Revision 1.45  2007/05/01 16:40:06  southa
# Level 10
#
# Revision 1.44  2007/04/26 13:12:39  southa
# Limescale and level 9
#
# Revision 1.43  2007/04/20 19:28:08  southa
# Level 8 work
#
# Revision 1.42  2007/04/20 12:07:08  southa
# Khazi Warehouse and level 8
#
# Revision 1.41  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.40  2007/03/28 14:45:46  southa
# Level and AI standoff
#
# Revision 1.39  2007/03/26 16:31:35  southa
# L2 work
#
# Revision 1.38  2007/03/23 18:39:08  southa
# Carriers and spawning
#
# Revision 1.37  2007/03/23 12:27:34  southa
# Added levels and Cistern mesh
#
# Revision 1.36  2007/03/20 20:36:54  southa
# Solid renderer fixes
#
# Revision 1.35  2007/03/09 19:50:10  southa
# Resident textures
#
# Revision 1.34  2007/03/06 11:34:01  southa
# Space and precache fixes
#
# Revision 1.33  2007/02/08 17:55:12  southa
# Common routines in space generation
#
# Revision 1.32  2006/12/18 15:39:35  southa
# Palette changes
#
# Revision 1.31  2006/12/16 10:57:21  southa
# Encrypted files
#
# Revision 1.30  2006/11/17 15:47:42  southa
# Ammo remnants
#
# Revision 1.29  2006/11/17 13:22:06  southa
# Box textures
#
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
    @m_boxNames = %w{ health shield base lightcannon quadcannon flak
      heavycannon rail lightmissile heavymissile flush nuclear }
  end

  mush_reader :m_exploNames, :m_boxNames, :m_cosmos1Names

  def mCreate
    levelOfDetail = MushGame.cTextureDetail
    if AdanaxisRuby.cApply2020Makeover == 1
      edgeProximityDistScale = 1
      edgeProximityDist = 0.04
    else
      edgeProximityDistScale = 0
      edgeProximityDist = 0
    end
    edgeProximityCol = [1.0, 1.0, 1.0, 0.3]
    textureSize = 256 * (2 ** levelOfDetail);
    smallTextureSize = 128 * (2 ** levelOfDetail);
    largeTextureSize = 512 * (2 ** levelOfDetail);
    starTextureSize = 32 * (2 ** levelOfDetail)
    flareTextureSize = smallTextureSize

    compressNear = true
    compressFar = true

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

  mBoxNames.each do |name|
    filename = MushConfig.cGlobalPixelsPath+"/#{name}box1.tiff"
    MushLog.cWarning("Missing box texture #{filename}") unless File.file?(filename)
    MushGLTexture::cDefine(
      :name          => "#{name}box1-tex",
      :type          => 'TIFF',
      :filename      => filename,
      :storagetype   => 'GL',
      :cache         => 0,
      :compress      => compressNear,
      :resident      => 1
    )
  end


  (1..3).each do |ballNum|
    MushGLTexture::cDefine(
      :name          => "ball#{ballNum}-tex",
      :type          => 'TIFF',
      :filename      => MushConfig.cGlobalPixelsPath+"/ball#{ballNum}.tiff",
      :storagetype   => 'GL',
      :cache         => 0,
      :compress      => compressFar,
      :resident      => 1
    )
  end

  MushGLTexture::cDefine(
    :name          => "rail1-tex",
    :type          => 'TIFF',
    :filename      => MushConfig.cGlobalPixelsPath+'/rail1.tiff',
    :storagetype   => 'GL',
    :cache         => 0,
    :compress      => compressFar,
    :resident      => 1
  )

  @m_explo1Names = []
  maxExplos = case levelOfDetail
    when 0 then 2
    when 1 then 4
    else 8
  end

  maxExplos.times do |exploNum|
    100.times do |i|
      filename = "mush://pixels/artb-explo#{exploNum}-#{i}.tiff|#{MushConfig.cGlobalPixelsPath}/explo#{exploNum}-#{i}.tiff"
      if MushFile.cFile?(filename)
        texName = "explo#{exploNum}-tex-#{i}"
        @m_exploNames[exploNum] ||= []
        @m_exploNames[exploNum] << texName
        MushGLTexture::cDefine(
          :name          => texName,
          :type          => 'TIFF',
          :filename      => filename,
          :storagetype   => 'GL',
          :cache         => 0,
          :compress      => compressFar,
          :resident      => 1
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
        :compress      => compressFar,
        :resident      => 1
      )
    end
  end

  scale = 1.4

	MushGLTexture::cDefine(
		:name          => 'drone-tex',
    :type          => 'CellNoise',
    :meshname      => 'drone',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

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
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

	MushGLTexture::cDefine(
		:name          => 'attendant-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'attendant-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.9],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

	MushGLTexture::cDefine(
		:name          => 'attendant-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'attendant-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.1],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)


  scale = 0.2
  MushGLTexture::cDefine(
		:name          => 'bleach-tex',
    :type          => 'CellNoise',
    :meshname      => 'bleach',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.5],
    :palettevector => [4.0,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'bleach-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'bleach-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.6],
    :palettevector => [4.0,3.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'bleach-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'bleach-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.4],
    :palettevector => [4.0,-3.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.2
  MushGLTexture::cDefine(
		:name          => 'cistern-tex',
    :type          => 'CellNoise',
    :meshname      => 'cistern',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [0.99,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'cistern-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'cistern-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.6],
    :palettevector => [0.99,0.4],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'cistern-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'cistern-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.4],
    :palettevector => [0.99,-0.4],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.5
  MushGLTexture::cDefine(
		:name          => 'door-tex',
    :type          => 'CellNoise',
    :meshname      => 'door',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.5],
    :palettevector => [4.0,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 4,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'door-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'door-red',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.6],
    :palettevector => [4.0,3.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 4,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'door-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'door-blue',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.4],
    :palettevector => [4.0,-3.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 4,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.1
  MushGLTexture::cDefine(
		:name          => 'floater-tex',
    :type          => 'CellNoise',
    :meshname      => 'floater',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [1.0,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'floater-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'floater-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.4],
    :palettevector => [1.0,0.6],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'floater-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'floater-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.6],
    :palettevector => [1.0,-0.6],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.5
  MushGLTexture::cDefine(
		:name          => 'freshener-tex',
    :type          => 'CellNoise',
    :meshname      => 'freshener',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0.5,0.0],
    :palettevector => [0,1.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'freshener-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'freshener-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0.5,0.0],
    :palettevector => [0.5,1.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'freshener-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'freshener-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0.5,0.0],
    :palettevector => [-0.5,1.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.5
  MushGLTexture::cDefine(
		:name          => 'harpik-tex',
    :type          => 'CellNoise',
    :meshname      => 'harpik',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [0.99,0.0],
		:scale         => [scale, scale, scale, scale/4],
    :numoctaves    => 3,
    :octaveratio   => 0.7,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'harpik-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'harpik-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.8],
    :palettevector => [0.99,0.2],
		:scale         => [scale, scale, scale, scale/4],
    :numoctaves    => 3,
    :octaveratio   => 0.7,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'harpik-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'harpik-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.2],
    :palettevector => [0.99,-0.2],
		:scale         => [scale, scale, scale, scale/4],
    :numoctaves    => 3,
    :octaveratio   => 0.7,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.05
  MushGLTexture::cDefine(
		:name          => 'hub-tex',
    :type          => 'CellNoise',
    :meshname      => 'hub',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [4.0,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.4,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'hub-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'hub-red',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.9],
    :palettevector => [1.0,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.4,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'hub-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'hub-blue',
    :size          => [largeTextureSize, largeTextureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.4],
    :palettevector => [4.0,-3.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.4,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.5
  MushGLTexture::cDefine(
		:name          => 'limescale-tex',
    :type          => 'CellNoise',
    :meshname      => 'limescale',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0.1,0.3],
    :palettevector => [0,0.4],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'limescale-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'limescale-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0.8,0.6],
    :palettevector => [0,0.4],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'limescale-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'limescale-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0.8,0.4],
    :palettevector => [0,-0.4],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.1
  MushGLTexture::cDefine(
		:name          => 'vendor-tex',
    :type          => 'CellNoise',
    :meshname      => 'vendor',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [1.0,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'vendor-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'vendor-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.4],
    :palettevector => [1.0,0.6],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'vendor-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'vendor-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.6],
    :palettevector => [1.0,-0.6],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.1
  MushGLTexture::cDefine(
		:name          => 'vortex-tex',
    :type          => 'CellNoise',
    :meshname      => 'vortex',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.5],
    :palettevector => [1.0,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'vortex-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'vortex-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.4],
    :palettevector => [2.0,0.7],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'vortex-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'vortex-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.6],
    :palettevector => [2.0,-0.7],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.5,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.1
  MushGLTexture::cDefine(
		:name          => 'warehouse-tex',
    :type          => 'CellNoise',
    :meshname      => 'warehouse',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.5],
    :palettevector => [4.0,0.0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.625,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'warehouse-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'warehouse-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.4],
    :palettevector => [4.0,0.6],
		:scale         => [scale, scale, scale, scale/1.5],
    :numoctaves    => 8,
    :octaveratio   => 0.625,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  MushGLTexture::cDefine(
		:name          => 'warehouse-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'warehouse-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette1',
    :palettestart  => [0,0.6],
    :palettevector => [4.0,-0.6],
		:scale         => [scale, scale, scale, scale/1.5],
    :numoctaves    => 8,
    :octaveratio   => 0.625,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

  scale = 0.1
	MushGLTexture::cDefine(
		:name          => 'rail-tex',
    :type          => 'CellNoise',
    :meshname      => 'rail',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.5],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.6,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => 1.5 * edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

	MushGLTexture::cDefine(
		:name          => 'rail-red-tex',
    :type          => 'CellNoise',
    :meshname      => 'rail-red',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.9],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.6,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => 1.5 * edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
	)

	MushGLTexture::cDefine(
		:name          => 'rail-blue-tex',
    :type          => 'CellNoise',
    :meshname      => 'rail-blue',
    :size          => [textureSize, textureSize],
    :palette       => 'palette3',
    :palettestart  => [0,0.1],
    :palettevector => [0.99,0],
		:scale         => [scale, scale, scale, scale],
    :numoctaves    => 8,
    :octaveratio   => 0.6,
		:cache         => 1,
    :compress      => compressNear,
    :edgeproximitydist => 1.5 * edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressFar,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressFar,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
    :compress      => compressNear,
    :edgeproximitydist => edgeProximityDist,
    :edgeproximitycol => edgeProximityCol
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
      :compress      => compressFar,
      :resident      => 1
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
      :compress      => compressNear,
      :resident      => 1
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
      :compress      => compressNear,
      :resident      => 1
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

