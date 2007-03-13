#%Header {
##############################################################################
#
# File data-adanaxis/pixels/MakeCosmos.rb
#
# Author Andy Southgate 2006-2007
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
#%Header } J1GnEbuS+g4XtXTbkPAWeg
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
