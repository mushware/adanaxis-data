#%Header {
##############################################################################
#
# File: data-adanaxis/ruby/AdanaxisLevels.rb
#
# Copyright: Andy Southgate 2006
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
#%Header } cFwQAtyHnNl+l2a5tyRljw
# $Id$
# $Log$

require 'Mushware.rb'

class AdanaxisLevels
  LEVEL_MANIFEST_NAME = 'manifest.txt'
  KEY = 0
  PARAMS = 1
  def initialize
    @levels = []
    @validParams = %w{directory name creator visibility}
  end
  
  def mScanLevel(path)
    manifestFile = "#{path}/#{LEVEL_MANIFEST_NAME}"
    manifestFile.untaint
    baseName = File.basename(path)
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
            unless @validParams.index(name)
              puts "Unknown parameter '#{name}' in manifest"
            else
              paramHash[name] = value
            end
          end
        end
      end
      
      if paramHash['directory'] != baseName
        paramHash['name'] = baseName
        puts "Discarding level name because directory in manifest '#{paramHash['directory']}' doesn't match actual directory '#{baseName}'"
      end
      
      @levels.push [baseName, paramHash]
    end
  end
  
  def mLevelList
    @levels
  end
  
  def mScanForLevels
    @levels = []
    spacePath = MushConfig.cGlobalSpacesPath
    Dir.foreach(spacePath) do |leafName|
      next if leafName == 'CVS' || leafName =~ /\./
      mScanLevel(spacePath+'/'+leafName)
    end
  end
end
