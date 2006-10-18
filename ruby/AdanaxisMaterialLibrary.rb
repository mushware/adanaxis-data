#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisMaterialLibrary.rb
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
#%Header } Qn1dyBC0obbg8YEx3MpSKg
# $Id: AdanaxisMaterialLibrary.rb,v 1.11 2006/10/17 15:28:00 southa Exp $
# $Log: AdanaxisMaterialLibrary.rb,v $
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
    MushMaterial.cDefine(
      :name => 'attendant-mat',
      :texture_names => ['attendant-tex']
    )
    MushMaterial.cDefine(
      :name => 'player-mat',
      :texture_names => ['player-tex']
    )
    MushMaterial.cDefine(
      :name => 'projectile-mat',
      :texture_names => ['projectile-tex']
    )
    MushMaterial.cDefine(
      :name => 'world1-mat',
      :texture_names => ['world1-tex']
    )
    10.times do |i|
      MushMaterial.cDefine(
      :name => "star#{i}-mat",
      :texture_names => ["star#{i}-tex"]
      )
    end
    10.times do |i|
      MushMaterial.cDefine(
      :name => "ember#{i}-mat",
      :texture_names => ["ember#{i}-tex"]
      )
    end
    10.times do |i|
      MushMaterial.cDefine(
      :name => "flare#{i}-mat",
      :texture_names => ["flare#{i}-tex"]
      )
    end
    
    if @m_textureLibrary.mExplo1Names.size > 0
      10.times do |i|
        MushMaterial.cDefine(
        :name => "explo#{i}-mat",
        :texture_names => @m_textureLibrary.mExplo1Names
        )
      end
    else
      10.times do |i|
        MushMaterial.cDefine(
        :name => "explo#{i}-mat",
        :texture_names => ["flare#{i}-tex"]
        )
      end    
    end

    if @m_textureLibrary.mCosmos1Names.size > 0
      @m_textureLibrary.mCosmos1Names.size.times do |i|
        MushMaterial.cDefine(
          :name => "cosmos1-#{i}-mat",
          :texture_names => [@m_textureLibrary.mCosmos1Names[i]]
        )
      end  
    end

    [ 'ground', 'river', 'block' ].each do |prefix|
      MushMaterial.cDefine(
        :name => "#{prefix}1-mat",
        :texture_names => ["#{prefix}1-tex"]
      )
    end
  end
end
