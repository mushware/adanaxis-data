#%Header {
##############################################################################
#
# File data-adanaxis/spaces/level1/space.rb
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
#%Header } ymklWNnUsMW6L2JnkUUK9g
# $Id$
# $Log$

require 'Mushware.rb'
require 'Adanaxis.rb'

class Adanaxis_level1 < AdanaxisSpace
  def initialize(inParams = {})
    super
    mSpawnAdd(:mSpawn0)
  end
  
  def mLoad(game)
    mLoadStandard(game)
    mMusicAdd('game1', 'mushware-extensions-to-space.ogg')
  end
  
  def mPrecacheListBuild
    super
    mPrecacheListAdd(mPieceLibrary.mAttendantTex('red'))
  end
  
  def mInitialPiecesCreate
    super
    (-2..2).each do |i|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(i * 50, -40, 0, -100-20*i.abs),
          :angular_position => MushTools.cRandomOrientation
        ),
        :waypoint => MushVector.new(i * 30, -0, i * 15, -250),
        :waypoint_msec => 15000,
        :ai_state => :waypoint_timed
      )
    end

    mStandardCosmos(1)
  end
  
  def mSpawn0
    (-1..1).each do |i|
      mPieceLibrary.mAttendantCreate(
        :colour => 'red',
        :post => MushPost.new(
          :position => MushVector.new(i * 50, -40, 0, -100-20*i.abs),
          :angular_position => MushTools.cRandomOrientation
        ),
        :waypoint => MushVector.new(i * 30, -0, i * 15, -250),
        :waypoint_msec => 15000,
        :ai_state => :waypoint_timed,
        :spawned => true
      )
    end
    return true
  end
end
