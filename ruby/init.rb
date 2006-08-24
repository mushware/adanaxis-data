#%Header {
##############################################################################
#
# File data-adanaxis/ruby/init.rb
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
#%Header } sDsEhHIN+GUpI3Anu4wz2g
# $Id: init.rb,v 1.16 2006/08/03 13:49:58 southa Exp $
# $Log: init.rb,v $
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


