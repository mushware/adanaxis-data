#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisAIProjectile.rb
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
#%Header } r/Msx9dDXUMbo10AONC6Rw
# $Id: AdanaxisAIProjectile.rb,v 1.5 2007/06/27 12:58:10 southa Exp $
# $Log: AdanaxisAIProjectile.rb,v $
# Revision 1.5  2007/06/27 12:58:10  southa
# Debian packaging
#
# Revision 1.4  2007/04/18 09:21:51  southa
# Header and level fixes
#
# Revision 1.3  2007/04/16 08:41:05  southa
# Level and header mods
#
# Revision 1.2  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.1  2006/11/12 20:09:54  southa
# Missile guidance
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'

class AdanaxisAIProjectile < AdanaxisAI

  def mStateActionProjectileSeek
    onTarget = false
    unless @m_targetID
      # No target to seek
      mStateChange(AISTATE_IDLE)
    else
      begin
        targetPiece = MushGame.cPieceLookup(@m_targetID)
        targetPos = targetPiece.post.position
        onTarget = MushUtil.cMissileSeek(@r_post,
          targetPos, # Target
          @m_seekSpeed, # Maximum speed
          @m_seekAcceleration # Acceleration
        )
      rescue Exception => e
        # Target probably destroyed
        @m_targetID = nil
      end
    end

    100
  end


  def mActMain
    case @m_state
      when AISTATE_IDLE
        callInterval = nil
      when AISTATE_DORMANT
        mStateChange(AISTATE_PROJECTILE_SEEK)
        callInterval = 100
      when AISTATE_PROJECTILE_SEEK
        callInterval = mStateActionProjectileSeek
      else callInterval = super
    end

    callInterval
  end

end
