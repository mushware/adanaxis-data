#%Header {
##############################################################################
#
# File adanaxis-data/ruby/init.rb
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
#%Header } vTCcQnAqfucts8hBb5tOZA
# $Id: init.rb,v 1.17 2006/08/24 13:04:37 southa Exp $
# $Log: init.rb,v $
# Revision 1.17  2006/08/24 13:04:37  southa
# Event handling
#
# Revision 1.16  2006/08/03 13:49:58  southa
# X11 release work
#
# Revision 1.15  2006/08/01 17:21:19  southa
# River demo
#
# Revision 1.14  2006/08/01 13:41:13  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'Adanaxis.rb'

$currentGame = AdanaxisGame.new
$currentLogic = AdanaxisLogic.new

begin
  require 'test/run_tests.rb' if $MUSHCONFIG['DEBUG'] && File.file?('../mushruby/test/run_tests.rb')
rescue Exception
  # Ignore failure
end


