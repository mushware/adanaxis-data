#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushView.rb
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
#%Header } j94Ie0img3DBbWXASWobyw
# $Id: MushView.rb,v 1.1 2006/10/17 15:27:59 southa Exp $
# $Log: MushView.rb,v $
# Revision 1.1  2006/10/17 15:27:59  southa
# Player collisions
#

require 'MushObject.rb'
require 'MushDashboard.rb'

class MushView < MushObject
  def initialize(inParams = {})
    @m_dashboard = inParams[:dashboard] || MushDashboard.new
  end
  
  mush_accessor :m_dashboard
  
  def mDashboardRender(inParams = {})
    @m_dashboard.mRender(inParams)
  end
end
