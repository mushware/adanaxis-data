#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisLevels.rb
#
# Copyright Andy Southgate 2006
#
# This file may be used and distributed under the terms of the Mushware
# software licence version 1.1, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } YkolAA2/khvOmyZz3VmddA
# $Id: AdanaxisLevels.rb,v 1.6 2007/03/08 11:00:29 southa Exp $
# $Log: AdanaxisLevels.rb,v $
# Revision 1.6  2007/03/08 11:00:29  southa
# Level epilogue
#
# Revision 1.5  2007/03/07 11:29:23  southa
# Level permission
#
# Revision 1.4  2006/08/01 17:21:17  southa
# River demo
#
# Revision 1.3  2006/08/01 13:41:11  southa
# Pre-release updates
#

require 'Mushware.rb'

class AdanaxisLevels
  LEVEL_MANIFEST_NAME = 'manifest.txt'
  KEY = 0
  PARAMS = 1
  def initialize
    @m_levels = []
    @m_validParams = %w{directory name creator visibility permit next}
  end
  
  def mScanLevel(path)
    manifestFile = "#{path}/#{LEVEL_MANIFEST_NAME}"
    manifestFile.untaint
    baseName = File.basename(path).untaint
    unless File.file?(manifestFile)
      puts "Manifest file #{manifestFile} missing from space directory" 
    else
      paramHash = {}
      File.open(manifestFile) do |file|
        file.each do |line|
          next if line =~ /^$/ || line =~ /^#/
          unless line =~ /(\w+)\s*=\s*'([^']*)'/
            puts "Syntax error in '#{line}'"
          else
            name, value = $1, $2
            unless @m_validParams.index(name)
              puts "Unknown parameter '#{name}' in manifest"
            else
              paramHash[name.untaint] = value.untaint
            end
          end
        end
      end
      
      if paramHash['directory'] != baseName
        paramHash['name'] = baseName
        puts "Discarding level name because directory in manifest '#{paramHash['directory']}' doesn't match actual directory '#{baseName}'"
      end
      
      @m_levels.push [baseName, paramHash]
    end
  end
  
  def mLevelList
    @m_levels
  end
  
  def mScanForLevels
    @m_levels = []
    spacePath = MushConfig.cGlobalSpacesPath
    Dir.foreach(spacePath) do |leafName|
      next if leafName == 'CVS' || leafName =~ /\./
      mScanLevel(spacePath+'/'+leafName)
    end
  end
  
  def mLevelFind(inKey)
    @m_levels.each do |level|
      return level if inKey == level[AdanaxisLevels::KEY]
    end
    nil
  end
  
  def mNextLevelKey(inCurrent)
    retVal = nil
    level = mLevelFind(inCurrent)
    if level
      nextLevel = level[PARAMS]['next']
      if nextLevel
        retVal = nextLevel
      end
    end
    retVal
  end
end
