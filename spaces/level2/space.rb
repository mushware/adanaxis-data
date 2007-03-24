#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level2/space.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Commercial Software Licence version 1.2.  If not supplied with this software
# a copy of the licence can be obtained from Mushware Limited via
# http://www.mushware.com/.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } himjbU5Z2u0qw2m4GmfqzA
# $Id: space.rb,v 1.1 2007/03/23 12:27:35 southa Exp $
# $Log: space.rb,v $
# Revision 1.1  2007/03/23 12:27:35  southa
# Added levels and Cistern mesh
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level2 < AdanaxisSpace
  def initialize(inParams = {})
    super
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
    mPrecacheListAdd(mPieceLibrary.mCisternTex('red'))
  end
  
  def mInitialPiecesCreate
    super
    (-0..0).each do |i|
      patrolPoints = [
        MushVector.new(i * 50, 200, -i*50, -100),
        MushVector.new(i * 50, -200, 50, -100),
        MushVector.new(i * 50, -200, i*50, -500),
        MushVector.new(i * 50, 200, -50, -500),
      ]
    
      angPos = MushTools.cRotationInXZPlane(Math::PI/2)
      MushTools.cRotationInYWPlane(Math::PI/2).mRotate(angPos)
      
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(i * 50, -40, 0, -600-20*i.abs),
          :velocity => MushVector.new(0, 0.1, 0, 0),
          :angular_position => angPos
        ),
        :patrol_points => patrolPoints,
        :patrol_msec => 6000,
        :ai_state => :patrol
      )
    end

    mStandardCosmos(2)
  end
end
