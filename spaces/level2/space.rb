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
# $Id: space.rb,v 1.2 2007/03/24 14:06:28 southa Exp $
# $Log: space.rb,v $
# Revision 1.2  2007/03/24 14:06:28  southa
# Cistern AI
#
# Revision 1.1  2007/03/23 12:27:35  southa
# Added levels and Cistern mesh
#

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level2 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mTimeoutSpawnAdd(:mSpawn0, 30000) if AdanaxisRuby.cGameDifficulty > 0
    mTimeoutSpawnAdd(:mSpawn1, 60000) if AdanaxisRuby.cGameDifficulty > 1
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
  
  def mCisternCreate(inRange, inOffset = MushVector.new(0,0,0,0))
    inRange.each do |i|
      patrolPoints = [
        MushVector.new(i * 50, 200, -i*50, -100),
        MushVector.new(i * 50, -200, 50, -100),
        MushVector.new(i * 50, -200, i*50, -500),
        MushVector.new(i * 50, 200, -50, -500),
      ]

      patrolPoints.map! { |vec| inOffset + vec }
    
      angPos = MushTools.cRotationInXZPlane(Math::PI/2)
      MushTools.cRotationInYWPlane(Math::PI/2).mRotate(angPos)
      
      mPieceLibrary.mCisternCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(i * 50, -40, 0, -600-20*i.abs) + inOffset,
          :velocity => MushVector.new(0, 0.1, 0, 0),
          :angular_position => angPos
        ),
        :patrol_points => patrolPoints
      )
    end
  end
  
  def mInitialPiecesCreate
    super
    mCisternCreate(0..0)
    mStandardCosmos(2)
  end
  
  def mSpawn0
    mCisternCreate(-1..1, MushVector.new(0,0,0,-200))
  end

  def mSpawn1
    mCisternCreate(-2..2, MushVector.new(0,0,0,-400))
    (-1..1).each do |i|
      $currentLogic.mRemnant.mCreate(
        :item_type => :player_heavy_missile,
        :post => MushPost.new(
          :position => MushVector.new(0, 0, 0, -500-5*i)),
        :spawned => true
      )
    end
  end
end
