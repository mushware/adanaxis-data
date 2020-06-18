#%Header {
##############################################################################
#
# File adanaxis-data/pixels/MakeAnimation.rb
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
#%Header } 8smgQQLJ9/eHEHIjX+ZqCQ
##############################################################################
#
# File data-adanaxis/pixels/MakeAnimation.rb
#
# Author Andy Southgate 2006
#
# This file contains original work by Andy Southgate.  The author and his
# employer (Mushware Limited) irrevocably waive all of their copyright rights
# vested in this particular version of this file to the furthest extent
# permitted.  The author and Mushware Limited also irrevocably waive any and
# all of their intellectual property rights arising from said file and its
# creation that would otherwise restrict the rights of any party to use and/or
# distribute the use of, the techniques and methods used herein.  A written
# waiver can be obtained via http://www.mushware.com/.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
# $Id: MakeAnimation.rb,v 1.1 2006/10/05 15:39:16 southa Exp $
# $Log: MakeAnimation.rb,v $
# Revision 1.1  2006/10/05 15:39:16  southa
# Explosion handling
#

$LOAD_PATH.push File.dirname($0)+"/../../scripts"
require 'ProcessAnimation.rb'

processAnimation = ProcessAnimation.new(
  :control_file => $0,
  :source_path => File.dirname($0)+"/../pixelsrc"
  )
processAnimation.mProcess(
  :source_prefix => "RE410",
  :source_suffix => ".tif",
  :destination_prefix => "copyright-explo1-"
)
