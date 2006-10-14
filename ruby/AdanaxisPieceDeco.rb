#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceDeco.rb
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
#%Header } xOGGCYeMt0BNCjURov3s3Q
# $Id$
# $Log$

class AdanaxisPieceDeco < MushPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    @m_defaultType = "d"
    super
    @m_lifeMsec = inParams[:lifetime_msec] || 0
    @m_renderScale = inParams[:render_scale] || 1.0
  end
end
