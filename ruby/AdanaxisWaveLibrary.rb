#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisWaveLibrary.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.2, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } XfyFHmUDC1Twjz+2BDP/kQ
# $Id: AdanaxisWaveLibrary.rb,v 1.6 2007/03/13 21:45:09 southa Exp $
# $Log: AdanaxisWaveLibrary.rb,v $
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
    MushGame.cSoundDefine('nuke_explo1', "mush://waves/sdog-explo7.wav|#{MushConfig.cGlobalWavesPath}/collect1.wav")
    8.times do |i|
      MushGame.cSoundDefine("explo#{i}", "mush://waves/sdog-explo#{i}.wav|#{MushConfig.cGlobalWavesPath}/explode.wav")
    end
    10.times do |i|
      MushGame.cSoundDefine("fire#{i}", "mush://waves/sdog-fire#{i}.wav|#{MushConfig.cGlobalWavesPath}/fire.wav")
      MushGame.cSoundDefine("load#{i}", "mush://waves/sdog-load#{i}.wav|#{MushConfig.cGlobalWavesPath}/collect1.wav")
    end
    MushGame.cSoundDefine("shieldcollect1", "mush://waves/sdog-shieldcollect1.wav|#{MushConfig.cGlobalWavesPath}/collect1.wav")
    MushGame.cSoundDefine("healthcollect1", "mush://waves/sdog-healthcollect1.wav|#{MushConfig.cGlobalWavesPath}/collect1.wav")

  end
end
