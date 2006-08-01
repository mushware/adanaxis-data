#%Header {
##############################################################################
#
# File: data-adanaxis/ruby/AdanaxisMaterialLibrary.rb
#
# Copyright: Andy Southgate 2006
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
#%Header } GjB24Qk7hUG2G2QuwJ61bw
# $Id$
# $Log$

class AdanaxisMaterialLibrary < MushObject
  def self.cCreate
	MushMaterial.cDefine(
	  :name => 'attendant-mat',
	  :texture_name => 'attendant-tex'
	)
	MushMaterial.cDefine(
	  :name => 'projectile-mat',
	  :texture_name => 'projectile-tex'
	)
	MushMaterial.cDefine(
	  :name => 'world1-mat',
	  :texture_name => 'world1-tex'
	)
  10.times do |i|
    MushMaterial.cDefine(
    :name => "star#{i}-mat",
    :texture_name => "star#{i}-tex"
    )
  end
  10.times do |i|
    MushMaterial.cDefine(
    :name => "ember#{i}-mat",
    :texture_name => "ember#{i}-tex"
    )
  end
  10.times do |i|
    MushMaterial.cDefine(
    :name => "flare#{i}-mat",
    :texture_name => "flare#{i}-tex"
    )
  end


  end
end
