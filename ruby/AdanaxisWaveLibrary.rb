#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisWaveLibrary.rb
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
#%Header } k0OwuxbYunzv3JtJrHodsw
# $Id: AdanaxisWaveLibrary.rb,v 1.11 2007/06/27 12:58:13 southa Exp $
# $Log: AdanaxisWaveLibrary.rb,v $
# Revision 1.11  2007/06/27 12:58:13  southa
# Debian packaging
#
# Revision 1.10  2007/05/10 11:44:12  southa
# Level15
#
# Revision 1.9  2007/04/18 09:21:54  southa
# Header and level fixes
#
# Revision 1.8  2007/04/17 10:08:12  southa
# Voice work
#
# Revision 1.7  2007/04/16 08:41:07  southa
# Level and header mods
#
# Revision 1.6  2007/03/13 21:45:09  southa
# Release process
#
# Revision 1.5  2006/12/16 10:57:21  southa
# Encrypted files
#
# Revision 1.4  2006/11/10 20:17:11  southa
# Audio work
#
# Revision 1.3  2006/11/06 19:27:51  southa
# Mushfile handling
#
# Revision 1.2  2006/11/06 12:56:31  southa
# MushFile work
#
# Revision 1.1  2006/11/03 18:46:32  southa
# Damage effectors
#

class AdanaxisWaveLibrary < MushObject
  def mCreate
    8.times do |i|
      MushGame.cSoundDefine("explo#{i}", "mush://waves/sdog-explo#{i}.wav|#{MushConfig.cGlobalWavesPath}/gpl-explo#{i}.wav|null:")
    end
    10.times do |i|
      MushGame.cSoundDefine("fire#{i}", "mush://waves/sdog-fire#{i}.wav|#{MushConfig.cGlobalWavesPath}/gpl-fire#{i}.wav|null:")
      MushGame.cSoundDefine("load#{i}", "mush://waves/sdog-load#{i}.wav|#{MushConfig.cGlobalWavesPath}/gpl-load#{i}.wav|null:")
    end
    MushGame.cSoundDefine("shieldcollect0", "mush://waves/sdog-shieldcollect0.wav|#{MushConfig.cGlobalWavesPath}/gpl-shieldcollect0.wav|null:")
    MushGame.cSoundDefine("healthcollect0", "mush://waves/sdog-healthcollect0.wav|#{MushConfig.cGlobalWavesPath}/gpl-healthcollect0.wav|null:")

    (1..11).each do |i|
      case i
        when 9,10: num=4
        when 11: num=6
        else num=3
      end
      (1..num).each do |j|
        MushGame.cSoundDefine("voice-E#{i}-#{j}", "mush://waves/voice-E#{i}-#{j}.ogg|null:")
      end
    end
  end
end
