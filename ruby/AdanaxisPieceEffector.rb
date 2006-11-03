#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceEffector.rb
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
#%Header } yTzlWjZhcDQjs3FNriJdaw
# $Id$
# $Log$

class AdanaxisPieceEffector < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)
    @m_defaultType = "e"
    super
    @m_owner = inParams[:owner] || ""
    @m_lifeMsec = inParams[:lifetime_msec] || 0
  end
  
  def mDamageFactor(inPiece)
    separation = (mPost.position - inPiece.mPost.position).mMagnitude
    factor = ((@m_hitPoints - separation) / @m_hitPoints).mClamp(0.0, 1.0)
    factor *= factor * factor # 4D so inverse cube law
    return @m_damageFactor * factor
  end

end
