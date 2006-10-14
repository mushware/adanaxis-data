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
# $Id: AdanaxisPieceProjectile.rb,v 1.4 2006/10/13 14:21:26 southa Exp $
# $Log: AdanaxisPieceProjectile.rb,v $
# Revision 1.4  2006/10/13 14:21:26  southa
# Collision handling
#
# Revision 1.3  2006/10/04 13:35:21  southa
# Selective targetting
#
# Revision 1.2  2006/10/03 14:06:49  southa
# Khazi and projectile creation
#
# Revision 1.1  2006/08/25 01:44:56  southa
# Khazi fire
#

class AdanaxisPieceProjectile < MushPiece
  extend MushRegistered
  mushRegistered_install

  def initialize(inParams={})
    @m_defaultType = "f"
    super
    @m_owner = inParams[:owner] || ""
    @m_lifeMsec = inParams[:lifetime_msec] || 0
    @m_hitPoints = 1.0
  end
  
  def mOwner
    @m_owner
  end
  
  def mEventHandle(event)
    case event
      when MushEventCollision: mCollisionHandle(event)
      else super(event)
    end
    @m_callInterval
  end
  
  def mFatalCollisionHandle(event)
    # Generate the projectile explosion
  end
  
  def mCollisionHandle(event)
    mHitPointsSet(0.0) # Projectiles always get destroyed
    super
  end
  
  
end
