#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushPiece.rb
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
#%Header } pLqne74F6NZl4a589ShvmQ
# Class: MushPiece
#
# Description:
#
# This object contains a reference to a game piece.
#
# Method: new
#
# Creates a new MushPost object.  
#
# Parameters:
#
# type - Name of the type to use
#
# Returns:
#
# New MushPiece object
#
# Default:
#
# There is no default constructor.
#
# Example:
#
# (example)
# (end)
#
# Group: Links
#- Wrapper file:doxygen/class_mush_mesh_ruby_post.html
#- Implemetation file:doxygen/class_mush_mesh_posticity.html

class MushPiece < MushObject
  def initialize(inParams = {})
    raise "#{self.class} didn't set @m_defaultType before calling super" unless @m_defaultType
    type = inParams[:type] || @m_defaultType
    idSuffix = inParams[:id_suffix]
    
    @m_id = "#{type}:#{idSuffix}"
    
    @m_post = inParams[:post] || MushPost.new
    @m_meshName = inParams[:mesh_name] || ""
    @m_expireFlag = false
    @m_hitPoints = Float(inParams[:hit_points] || 0.0)
    @m_originalHitPoints = @m_hitPoints
    @m_alphaStutter = Float(inParams[:alpha_stutter] || 0.0)
    @m_renderScale = inParams[:render_scale] || 1.0
    unless @m_renderScale.kind_of?(MushVector)
      @m_renderScale = MushVector.new(@m_renderScale, @m_renderScale, @m_renderScale, @m_renderScale)
    end
    @m_damageFactor = 1.0
    @m_vulnerability = inParams[:vulnerability] || 1.0
    @m_creationMsec = MushGame.cGameMsec
  end

  mush_reader :m_id, :m_originalHitPoints
  mush_writer :m_damageFactor
  mush_accessor :m_post, :m_expireFlag, :m_hitPoints, :m_vulnerability

  def mPostWRef
    @m_post
  end    

  def mDamageFactor(inPiece)
    return @m_damageFactor
  end

  def mAgeMsec
    return MushGame.cGameMsec - @m_creationMsec
  end

  def mHitPointRatio
    @m_hitPoints / @m_originalHitPoints
  end

  def mDamageTake(inDamage, inPiece)
    amount = inDamage * mVulnerability
    @m_hitPoints -= amount
    return amount
  end

  def mEventHandle(event)
    retVal = nil
    case event
      when MushEventCollision then mCollisionHandle(event)
      when MushEventExpiry then mExpiryHandle(event)
      else MushLog.cWarning "Unhandled message #{event.class} in #{self.class}"
    end
    retVal || @m_callInterval
  end
  
  def mFatalCollisionHandle(event)
    @m_expireFlag = true
  end

  def mCollisionHandle(event)
    if @m_hitPoints <= 0.0 && !@m_expireFlag
      @m_expireFlag = true
      mFatalCollisionHandle(event)
    end
  end
  
  def mExpiryHandle(event)
  end
  
end
