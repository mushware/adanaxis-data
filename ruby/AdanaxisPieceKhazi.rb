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
# $Id: AdanaxisPieceKhazi.rb,v 1.21 2006/10/20 15:38:51 southa Exp $
# $Log: AdanaxisPieceKhazi.rb,v $
# Revision 1.21  2006/10/20 15:38:51  southa
# Item collection
#
# Revision 1.20  2006/10/17 15:28:00  southa
# Player collisions
#
# Revision 1.19  2006/10/16 22:00:20  southa
# Tweaks
#
# Revision 1.18  2006/10/16 15:25:57  southa
# Explosion lifetimes
#
# Revision 1.17  2006/10/16 14:36:50  southa
# Deco handling
#
# Revision 1.16  2006/10/14 16:59:43  southa
# Ruby Deco objects
#
# Revision 1.15  2006/10/13 14:21:25  southa
# Collision handling
#
# Revision 1.14  2006/10/08 11:31:31  southa
# Hit points
#
# Revision 1.13  2006/10/04 14:54:33  southa
# AI tweaks
#
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
require 'AdanaxisUtil.rb'

class AdanaxisPieceKhazi < AdanaxisPiece
  extend MushRegistered
  mushRegistered_install
  
  def initialize(inParams={})
    AdanaxisUtil.cSpellCheck(inParams)
    
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
    @m_remnant = inParams[:remnant]
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
  
  def mFatalCollisionHandle(event)
    super
    $currentLogic.mEffects.mExplode(
      :post => mPost,
      :embers => 100,
      :explosions => 1,
      :flares => 1,
      :ember_speed_range => (0.3..1.0),
      :ember_lifetime_range => (2000..3000),
      :explosion_scale_range => (6.0..7.0),
      :flare_scale_range => (20.0..25.0),
      :flare_lifetime_range => (600..700)
      )
    MushGame.cSoundPlay("explode", mPost)
    
    objPost = mPost.dup
    angVel = MushTools.cRotationInXYPlane(Math::PI / 200);
    MushTools.cRotationInZWPlane(Math::PI / 473).mRotate(angVel);
    MushTools.cRotationInYZPlane(Math::PI / 670).mRotate(angVel);

    objPost.velocity = MushVector.new(0,0,0,0)
    objPost.angular_velocity = angVel
    
    case event.mPiece2
      when AdanaxisPieceProjectile:
        mRemnantCreate if event.mPiece2.mOwner =~ /^p/
    end
    
  end
  
  def mCollisionHandle(event)
    super
    otherPiece = event.mPiece2
    case event.mPiece2
      when AdanaxisPieceProjectile:
        @m_ai.mTargetOverride(otherPiece.mOwner)
    end
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
