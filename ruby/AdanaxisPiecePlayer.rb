#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPiecePlayer.rb
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
#%Header } 1H+rLloObKxiiVjoIDjJFw
# $Id: AdanaxisPiecePlayer.rb,v 1.1 2006/10/02 17:25:03 southa Exp $
# $Log: AdanaxisPiecePlayer.rb,v $
# Revision 1.1  2006/10/02 17:25:03  southa
# Object lookup and target selection
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'
require 'AdanaxisEvents.rb'

class AdanaxisPiecePlayer < MushPiece
  extend MushRegistered
  mushRegistered_install
  
  def initialize
    @m_defaultType = "p"
    super
    @m_callInterval = 100
  end
end
