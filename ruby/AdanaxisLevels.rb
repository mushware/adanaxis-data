#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisLevels.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.4, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } awql8pmBxnDZkd78CilajQ
# $Id: AdanaxisLevels.rb,v 1.16 2007/06/27 12:58:10 southa Exp $
# $Log: AdanaxisLevels.rb,v $
# Revision 1.16  2007/06/27 12:58:10  southa
# Debian packaging
#
# Revision 1.15  2007/06/26 17:10:31  southa
# X11 tweaks
#
# Revision 1.14  2007/06/26 16:27:50  southa
# X11 tweaks
#
# Revision 1.13  2007/06/02 15:56:56  southa
# Shader fix and prerelease work
#
# Revision 1.12  2007/05/03 18:00:32  southa
# Level 11
#
# Revision 1.11  2007/05/01 16:40:06  southa
# Level 10
#
# Revision 1.10  2007/04/18 09:21:52  southa
# Header and level fixes
#
# Revision 1.9  2007/04/16 08:41:06  southa
# Level and header mods
#
# Revision 1.8  2007/03/13 21:45:07  southa
# Release process
#
# Revision 1.7  2007/03/09 11:29:12  southa
# Game end actions
#
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
  LEVEL_DEMO_MANIFEST_NAME = 'demo_manifest.txt'
  LEVEL_SPACE_NAME = 'space.rb'
  KEY = 0
  PARAMS = 1
  def initialize
    @m_levels = []
    @m_validParams = %w{directory name creator visibility permit next}
    @m_isDemo = (MushGame.cPackageID =~ /demo-/)
  end

  def mScanLevel(path)
    manifestFile = "#{path}/#{LEVEL_MANIFEST_NAME}".untaint
    if @m_isDemo
      demoManifestFile = "#{path}/#{LEVEL_DEMO_MANIFEST_NAME}".untaint
      if File.file?(demoManifestFile)
        manifestFile = demoManifestFile
      end
    end
    spaceFile = "#{path}/#{LEVEL_SPACE_NAME}".untaint
    baseName = File.basename(path).untaint
    unless File.file?(manifestFile)
      puts "Manifest file #{manifestFile} missing from space directory"
    else
      paramHash = {}
      File.open(manifestFile) do |file|
        file.each do |line|
          next if line =~ /^\w*$/ || line =~ /^#/
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

      unless File.file?(spaceFile)
        paramHash['unavailable'] = true
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
    @m_levels.sort! do |x, y|
      if x[KEY] =~ /^(\w+)(\d+)/
        xName, xNum = $1, $2
        if y[KEY] =~ /^(\w+)(\d+)/
          yName, yNum = $1, $2
          if xName != yName
            compVal = xName <=> yName
          else
            compVal = xNum <=> yNum
          end
        end
      end
      compVal || x[KEY] <=> y[KEY]
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
