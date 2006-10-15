#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisTargetSelect.rb
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
#%Header } PmZrlB540NRoM7MJ3U6CJQ
# $Id$
# $Log$

require 'Mushware.rb'

class AdanaxisTargetSelect < MushObject
  def self.cSelect(inPost, inTypes, inExcludeID)
    targetID = nil
    inTypes.each do |type|
      targetID = MushGame.cTargetPieceSelect(inPost, type, inExcludeID)
      break if targetID
    end
    targetID
  end
end