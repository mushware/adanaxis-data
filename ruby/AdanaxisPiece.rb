#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisPiece.rb
#
# Copyright: Andy Southgate 2002-2007, 2020
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##############################################################################
#%Header } caIChFFvAPbbwLeU5gfi2g
# $Id: AdanaxisPiece.rb,v 1.7 2007/06/27 12:58:11 southa Exp $
# $Log: AdanaxisPiece.rb,v $
# Revision 1.7  2007/06/27 12:58:11  southa
# Debian packaging
#
# Revision 1.6  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.5  2007/03/24 18:07:22  southa
# Level 3 work
#
# Revision 1.4  2007/03/13 21:45:08  southa
# Release process
#
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

  def mUnlimitedHealthAdd(inProportion)
    newValue = mHitPoints + inProportion * mOriginalHitPoints

    newValue = [mOriginalHitPoints, newValue].min

    mHitPointsSet(newValue)
  end

  def mUnlimitedShieldAdd(inProportion)
    newValue = mShield + inProportion * mOriginalShield

    newValue = [mOriginalShield, newValue].min

    mShieldSet(newValue)
  end
end
