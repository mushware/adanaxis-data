#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceProjectile.rb
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
#%Header } JPjWkwGvzd5d5LJLXnphkQ
# $Id: AdanaxisPieceProjectile.rb,v 1.1 2006/08/25 01:44:56 southa Exp $
# $Log: AdanaxisPieceProjectile.rb,v $
# Revision 1.1  2006/08/25 01:44:56  southa
# Khazi fire
#

class AdanaxisPieceProjectile < MushPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    super
    @m_owner = inParams[:owner] || ""
    @m_lifeMsec = inParams[:lifetime_msec] || 0
  end
end
