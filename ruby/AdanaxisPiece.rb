#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPiece.rb
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
#%Header } iJ1K74BKpcBau3IxsHns9Q
# $Id$
# $Log$

class AdanaxisPiece < MushPiece
  def initialize(inParams)
    super
  end

  def mRemnantCreate
    case @m_remnant
      when NilClass
        # No action
      when Symbol
        $currentLogic.mRemnant.mCreate(
          :type => @m_remnant,
          :post => mPost
        )
      when Hash
        $currentLogic.mRemnant.mCreate(@m_remnant.merge(
          :post => mPost
          )
        )
      else
        raise(RuntimeError, "Unknown remnant type #{@m_remnant.inspect}")
    end
  end
end
