#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceKhazi.rb
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
#%Header } aGTJVbl7QyXIWVg5D1mEzg
# $Id: AdanaxisPieceKhazi.rb,v 1.12 2006/10/04 13:35:21 southa Exp $
# $Log: AdanaxisPieceKhazi.rb,v $
# Revision 1.12  2006/10/04 13:35:21  southa
# Selective targetting
#
# Revision 1.11  2006/10/03 14:06:49  southa
# Khazi and projectile creation
#
# Revision 1.10  2006/09/30 13:46:32  southa
# Seek and patrol
#
# Revision 1.9  2006/09/29 10:47:56  southa
# Object AI
#
# Revision 1.8  2006/08/25 11:06:07  southa
# Snapshot
#
# Revision 1.7  2006/08/25 01:44:56  southa
# Khazi fire
#
# Revision 1.6  2006/08/24 16:30:55  southa
# Event handling
#
# Revision 1.5  2006/08/24 13:04:37  southa
# Event handling
#
# Revision 1.4  2006/08/20 14:19:20  southa
# Seek operation
#
# Revision 1.3  2006/08/19 09:12:09  southa
# Event handling
#
# Revision 1.2  2006/08/17 12:18:10  southa
# Event handling
#
# Revision 1.1  2006/08/17 08:57:10  southa
# Event handling
#

require 'Mushware.rb'
require 'AdanaxisAIKhazi.rb'
require 'AdanaxisEvents.rb'
require 'AdanaxisPieceProjectile.rb'

class AdanaxisPieceKhazi < MushPiece
  extend MushRegistered
  mushRegistered_install
  
  def initialize(inParams={})
    @m_defaultType = "k"
    super
    
    @m_callInterval = 100
    @numTimes = rand(30)
    
    aiParams = {
      :seek_speed => 0.02,
      :seek_acceleration => 0.01,
      :patrol_speed => 0.1,
      :patrol_acceleration => 0.01
    }.merge(inParams)
    
    @m_ai = AdanaxisAIKhazi.new(aiParams)
  end
  
  def mTimerHandle(event)
    puts "Timer event"
    mLoad
  end
  
  def mFireHandle(event)
    projPost = event.post.dup
    
    vel = MushVector.new(0,0,0,-1)
    
    projPost.angular_position.mRotate(vel)
    
    projPost.velocity = projPost.velocity + vel
    projPost.angular_velocity = MushRotation.new
    
    projectile = AdanaxisPieceProjectile.cCreate(
      :mesh_name => "projectile",
      :post => projPost,
      :owner => @m_id,
      :lifetime_msec => 15000
    )
  end

  def mEventHandle(event)
    case event
      when MushEventTimer: mTimerHandle(event)
      when AdanaxisEventFire: mFireHandle(event)
      else super(event)
    end
    @m_callInterval
  end

  def mActionTimer
    mLoad

    @m_callInterval = @m_ai.mActByState(self)

    @numTimes += 1
    mFire if (@numTimes % 30) == 0

    mSave
    
    $currentLogic.mReceiveSequence
    
    @m_callInterval
  end

  def mFire
    event = AdanaxisEventFire.new
    event.post = @m_post
    $currentLogic.mEventConsume(event, @m_id, @m_id)  
  end
end

# Class: AdanaxisPieceKhazi
#
# Description:
#
# This object is used to define or reference a new Khazi object.
#
# Method: cCreate
#
# Creates a new AdanaxisKhazi object.  
#
# Parameters:
#
# post - Position/velocity <MushPost>
# mesh_name - Name of a previously created <MushMesh>.  A warning will be generated no mesh name is supplied
#
# Parameters must be supplied as a hash.
#
# Returns:
#
# New AdanaxisKhazi object
#
# Default:
#
# The default constructor creates an object with zero-values positions and velocities,
# and no mesh.
#
# Example:
#
# (example)
# post1 = AdanaxisPieceKhazi.cCreate
# post2 = AdanaxisPieceKhazi.cCreate(
#   post => MushPost.new(
#     :position => MushVector.new(1,2,3,4),
#     :angular_position => MushTools.cRotationInXYPlane(Math::PI/2),
#     :velocity => MushVector.new(0,0,0,-0.3),
#     :angular_velocity => MushTools.cRotationInZWPlane(Math::PI/20)
#   ),
#   :mesh_name => 'mymesh'
# )
#
# (end)
#
# Method: post
#
# Returns:
#
# Position/velocity <MushPost>
#
# Method: post=
#
# Sets the position and velocity.
#
# Parameter:
#
# Position/velocity <MushPost>
#
# Group: Links
#- Implemetation file:doxygen/class_adanaxis_piece_khazi.html
