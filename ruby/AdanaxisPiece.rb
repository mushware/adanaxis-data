#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPiece.rb
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
#%Header } 9VDXjMWD9ebIrDT+tsr1Fw
# $Id: AdanaxisPiece.rb,v 1.3 2006/11/01 10:07:13 southa Exp $
# $Log: AdanaxisPiece.rb,v $
# Revision 1.3  2006/11/01 10:07:13  southa
# Shield handling
#
# Revision 1.2  2006/10/30 19:36:38  southa
# Item collection
#
# Revision 1.1  2006/10/30 17:03:49  southa
# Remnants creation
#

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
          :item_type => @m_remnant,
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
  
  def mLimitedHealthAdd(inProportion)
    newValue = mHitPoints + inProportion * mOriginalHitPoints
    
    newValue = [mOriginalHitPoints, newValue].min
    newValue = [mHitPoints, newValue].max
    
    mHitPointsSet(newValue)
  end
  
  def mLimitedShieldAdd(inProportion)
    newValue = mShield + inProportion * mOriginalShield
    
    newValue = [mOriginalShield, newValue].min
    newValue = [mShield, newValue].max
    
    mShieldSet(newValue)
  end
end
