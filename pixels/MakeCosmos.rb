#%Header {
##############################################################################
#
# File adanaxis-data/pixels/MakeCosmos.rb
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
#%Header } T7XkXYQTCksv4fjTp9e7Ng
# $Id: MakeCosmos.rb,v 1.2 2006/11/09 23:53:58 southa Exp $
# $Log: MakeCosmos.rb,v $
# Revision 1.2  2006/11/09 23:53:58  southa
# Explosion and texture loading
#
# Revision 1.1  2006/10/18 13:21:58  southa
# World rendering
#

$LOAD_PATH.push File.dirname($0)+"/../../scripts"
require 'ProcessCosmos.rb'

processAnimation = ProcessCosmos.new(
  :control_file => $0,
  :source_path => File.dirname($0)+"/../pixelsrc/cosmos",
  :destination_path => "cosmos",
  :black_threshold => 0.02
  )
processAnimation.mProcess(
  :source_regexp => /\.jpe?g$/,
  :destination_prefix => "cosmos1-"
)
