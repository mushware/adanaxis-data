#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceEffector.rb
#
# Copyright Andy Southgate 2006-2007
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
#%Header } Go8gUlkOsaLZUOToZ9qVCw
# $Id: AdanaxisPieceEffector.rb,v 1.2 2006/11/14 20:28:36 southa Exp $
# $Log: AdanaxisPieceEffector.rb,v $
# Revision 1.2  2006/11/14 20:28:36  southa
# Added rail gun
#
# Revision 1.1  2006/11/03 18:46:31  southa
# Damage effectors
#

class AdanaxisPieceEffector < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "e"
    super
    @m_owner = inParams[:owner] || ""
    @m_lifeMsec = inParams[:lifetime_msec] || 0
    @m_rail = inParams[:rail] || false
  end
  
  mush_accessor :m_rail
  
  def mDamageFactor(inPiece)
    if @m_rail
      retVal = @m_damageFactor
    else
      separation = (mPost.position - inPiece.mPost.position).mMagnitude
      factor = ((@m_hitPoints - separation) / @m_hitPoints).mClamp(0.0, 1.0)
      factor *= factor * factor # 4D so inverse cube law
      retVal = @m_damageFactor * factor
    end
    retVal
  end

end
