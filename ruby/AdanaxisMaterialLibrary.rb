#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisMaterialLibrary.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } hU1TyrK37EoLKkw5zEmDXQ
# $Id: AdanaxisMaterialLibrary.rb,v 1.36 2007/06/27 12:58:11 southa Exp $
# $Log: AdanaxisMaterialLibrary.rb,v $
# Revision 1.36  2007/06/27 12:58:11  southa
# Debian packaging
#
# Revision 1.35  2007/06/14 12:14:15  southa
# Level 30
#
# Revision 1.34  2007/06/08 16:23:02  southa
# Level 26
#
# Revision 1.33  2007/06/06 12:24:12  southa
# Level 22
#
# Revision 1.32  2007/05/22 16:44:58  southa
# Level 18
#
# Revision 1.31  2007/05/10 11:44:11  southa
# Level15
#
# Revision 1.30  2007/05/08 15:28:13  southa
# Level 12
#
# Revision 1.29  2007/05/01 16:40:06  southa
# Level 10
#
# Revision 1.28  2007/04/26 13:12:39  southa
# Limescale and level 9
#
# Revision 1.27  2007/04/20 12:07:08  southa
# Khazi Warehouse and level 8
#
# Revision 1.26  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.25  2007/03/28 14:45:45  southa
# Level and AI standoff
#
# Revision 1.24  2007/03/23 12:27:34  southa
# Added levels and Cistern mesh
#
# Revision 1.23  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.22  2007/02/08 17:55:12  southa
# Common routines in space generation
#
# Revision 1.21  2006/12/18 15:39:34  southa
# Palette changes
#
# Revision 1.20  2006/11/17 15:47:41  southa
# Ammo remnants
#
# Revision 1.19  2006/11/17 13:22:06  southa
# Box textures
#
# Revision 1.18  2006/11/15 18:25:53  southa
# Khazi rails
#
# Revision 1.17  2006/11/14 20:28:35  southa
# Added rail gun
#
# Revision 1.16  2006/11/14 14:02:15  southa
# Ball projectiles
#
# Revision 1.15  2006/11/09 23:53:59  southa
# Explosion and texture loading
#
# Revision 1.14  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.13  2006/10/19 15:41:34  southa
# Item handling
#
# Revision 1.12  2006/10/18 13:22:08  southa
# World rendering
#
# Revision 1.11  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.10  2006/10/08 11:31:31  southa
# Hit points
#
# Revision 1.9  2006/10/06 14:48:17  southa
# Material animation
#
# Revision 1.8  2006/10/05 15:39:16  southa
# Explosion handling
#
# Revision 1.7  2006/08/01 17:21:17  southa
# River demo
#
# Revision 1.6  2006/08/01 13:41:12  southa
# Pre-release updates
#

class AdanaxisMaterialLibrary < MushObject
  def initialize(inParams = {})
    @m_textureLibrary = inParams[:texture_library] || raise("No texture library supplied to material library")
  end

  def mCreate
    tiledList = [
      'drone',
      'attendant',
      'attendant-red',
      'attendant-blue',
      'bleach',
      'bleach-red',
      'bleach-blue',
      'cistern',
      'cistern-red',
      'cistern-blue',
      'door',
      'door-red',
      'door-blue',
      'floater',
      'floater-red',
      'floater-blue',
      'freshener',
      'freshener-red',
      'freshener-blue',
      'harpik',
      'harpik-red',
      'harpik-blue',
      'hub',
      'hub-red',
      'hub-blue',
      'limescale',
      'limescale-red',
      'limescale-blue',
      'vendor',
      'vendor-red',
      'vendor-blue',
      'vortex',
      'vortex-red',
      'vortex-blue',
      'warehouse',
      'warehouse-red',
      'warehouse-blue',
      'rail',
      'rail-red',
      'rail-blue'
      ]

    tiledList.each do |name|
      MushMaterial.cDefine(
        :name => "#{name}-mat",
        :mapping_type => :tiled,
        :texture_names => ["#{name}-tex"]
      )
    end

    MushMaterial.cDefine(
      :name => 'player-mat',
      :mapping_type => :tiled,
      :texture_names => ['player-tex']
    )
    10.times do |i|
      MushMaterial.cDefine(
        :name => "projectile#{i}-mat",
        :mapping_type => :tiled,
        :texture_names => ["projectile#{i}-tex"]
      )
    end
    MushMaterial.cDefine(
      :name => 'world1-mat',
      :mapping_type => :tiled,
      :texture_names => ['world1-tex']
    )
    10.times do |i|
      MushMaterial.cDefine(
      :name => "ball#{i}-mat",
      :mapping_type => :singular,
      :texture_names => ["ball#{i}-tex"]
      )
    end
    10.times do |i|
      MushMaterial.cDefine(
      :name => "rail#{i}-mat",
      :mapping_type => :singular,
      :texture_names => ["rail#{i}-tex"]
      )
    end
    10.times do |i|
      MushMaterial.cDefine(
      :name => "star#{i}-mat",
      :mapping_type => :tiled,
      :texture_names => ["star#{i}-tex"]
      )
    end
    10.times do |i|
      MushMaterial.cDefine(
      :name => "ember#{i}-mat",
      :mapping_type => :tiled,
      :texture_names => ["ember#{i}-tex"]
      )
    end
    10.times do |i|
      MushMaterial.cDefine(
      :name => "flare#{i}-mat",
      :mapping_type => :tiled,
      :texture_names => ["flare#{i}-tex"]
      )
    end

    numExplo = @m_textureLibrary.mExploNames.size
    if numExplo > 0
      8.times do |i|
        texToUse = i
        texToUse = numExplo - 1 if texToUse >= numExplo

        MushMaterial.cDefine(
          :name => "explo#{i}-mat",
          :mapping_type => :tiled,
          :texture_names => @m_textureLibrary.mExploNames[texToUse]
        )
      end
    else
      8.times do |i|
        MushMaterial.cDefine(
          :name => "explo#{i}-mat",
          :mapping_type => :tiled,
          :texture_names => ["flare#{i}-tex"]
        )
      end
    end

    if @m_textureLibrary.mCosmos1Names.size > 0
      @m_textureLibrary.mCosmos1Names.size.times do |i|
        MushMaterial.cDefine(
          :name => "cosmos1-#{i}-mat",
          :mapping_type => :tiled,
          :texture_names => [@m_textureLibrary.mCosmos1Names[i]]
        )
      end
    end

    ['ground', 'river', 'block'].each do |prefix|
      MushMaterial.cDefine(
        :name => "#{prefix}1-mat",
        :mapping_type => :tiled,
        :texture_names => ["#{prefix}1-tex"]
      )
    end

    @m_textureLibrary.mBoxNames.each do |prefix|
      MushMaterial.cDefine(
        :name => "#{prefix}box1-mat",
        :mapping_type => :singular,
        :texture_names => ["#{prefix}box1-tex"]
      )
    end

    MushMaterial.cDefine(
      :name => "no-render-mat",
      :mapping_type => :tiled,
      :texture_names => [@m_textureLibrary.mCosmos1Names[2]]
    )
  end
end
