#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushEvents.rb
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
#%Header } hsoP9GyQilelpf+YG2f/1g
# $Id: MushEvents.rb,v 1.6 2007/03/13 21:45:02 southa Exp $
# $Log: MushEvents.rb,v $
# Revision 1.6  2007/03/13 21:45:02  southa
# Release process
#
# Revision 1.5  2006/10/17 11:05:54  southa
# Expiry events
#
# Revision 1.4  2006/10/14 16:59:43  southa
# Ruby Deco objects
#
# Revision 1.3  2006/10/13 14:21:25  southa
# Collision handling
#
# Revision 1.2  2006/10/12 22:04:45  southa
# Collision events
#
# Revision 1.1  2006/10/09 16:00:14  southa
# Intern generation
#
# Revision 1.1  2006/08/17 08:57:10  southa
# Event handling
#

require 'MushEvent.rb'

class MushEventTimer < MushEvent
  def initialize
    @id = 0
  end
  attr_accessor :id
end

class MushEventCollision < MushEvent
  mush_accessor :m_piece1, :m_piece2, :m_chunkNum1, :m_chunkNum2, :m_collisionPoint
  
  def mPiecesSwap!
    @m_piece1, @m_piece2 = @m_piece2, @m_piece1
    @m_chunkNum1, @m_chunkNum2 = @m_chunkNum2, @m_chunkNum1
  end
end

class MushEventExpiry < MushEvent
end
