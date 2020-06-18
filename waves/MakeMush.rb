#%Header {
##############################################################################
#
# File adanaxis-data/waves/MakeMush.rb
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
#%Header } zFG0b21GnJvZ2unrI4i6fQ
# $Id: MakeMush.rb,v 1.2 2006/11/06 12:56:31 southa Exp $
# $Log: MakeMush.rb,v $
# Revision 1.2  2006/11/06 12:56:31  southa
# MushFile work
#
# Revision 1.1  2006/11/05 09:31:23  southa
# Mush file generation
#

$LOAD_PATH.push File.dirname($0)+"/../../scripts"
require 'ProcessMush.rb'

process = ProcessMush.new(
  :control_file => $0,
  :destination_path =>'waves',
  :mush_file => '../mush/waves.mush'
)
process.mProcess
