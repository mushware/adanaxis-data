#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisTargetSelect.rb
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
#%Header } Za3OkrK8/87yHAnF21od2g
# $Id: AdanaxisTargetSelect.rb,v 1.4 2007/04/18 09:21:54 southa Exp $
# $Log: AdanaxisTargetSelect.rb,v $
# Revision 1.4  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.3  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.2  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.1  2006/10/02 20:28:09  southa
# Object lookup and target selection
#

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
