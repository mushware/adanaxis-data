#%Header {
##############################################################################
#
# File data-adanaxis/waves/MakeMush.rb
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
#%Header } bA+zXF6spqUFrZuwIA4AWQ
# $Id: MakeMush.rb,v 1.1 2006/11/05 09:31:23 southa Exp $
# $Log: MakeMush.rb,v $
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
