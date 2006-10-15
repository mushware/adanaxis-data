#%Header {
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
#%Header } wiRuKRB5m8n2tOJ8EczYZw
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
# $Id$
# $Log$

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