#%Header {
##############################################################################
#
# File data-adanaxis/ruby/Adanaxis.rb
#
# Copyright Andy Southgate 2006-2007
#
# This file may be used and distributed under the terms of the Mushware
# Software Licence version 1.3, under the terms for 'Proprietary original
# source files'.  If not supplied with this software, a copy of the licence
# can be obtained from Mushware Limited via http://www.mushware.com/.
# One of your options under that licence is to use and distribute this file
# under the terms of the GNU General Public Licence version 2.
#
# This software carries NO WARRANTY of any kind.
#
##############################################################################
#%Header } Z/0IM/eblOZbcUQpYNCCfg
# $Id: Adanaxis.rb,v 1.35 2007/04/20 12:07:07 southa Exp $
# $Log: Adanaxis.rb,v $
# Revision 1.35  2007/04/20 12:07:07  southa
# Khazi Warehouse and level 8
#
# Revision 1.34  2007/04/18 09:21:51  southa
# Header and level fixes
#
# Revision 1.33  2007/04/17 21:16:32  southa
# Level work
#
# Revision 1.32  2007/03/28 14:45:45  southa
# Level and AI standoff
#
# Revision 1.31  2007/03/27 14:01:02  southa
# Attendant AI
#
# Revision 1.30  2007/03/24 18:07:21  southa
# Level 3 work
#
# Revision 1.29  2007/03/23 18:39:07  southa
# Carriers and spawning
#
# Revision 1.28  2007/03/19 16:01:34  southa
# Damage indicators
#
# Revision 1.27  2007/03/13 21:45:06  southa
# Release process
#
# Revision 1.26  2007/02/08 17:55:12  southa
# Common routines in space generation
#
# Revision 1.25  2006/11/17 20:08:33  southa
# Weapon change and ammo handling
#
# Revision 1.24  2006/11/12 20:09:54  southa
# Missile guidance
#
# Revision 1.23  2006/11/03 18:46:31  southa
# Damage effectors
#
# Revision 1.22  2006/11/01 13:04:20  southa
# Initial weapon handling
#
# Revision 1.21  2006/10/30 17:03:49  southa
# Remnants creation
#
# Revision 1.20  2006/10/19 15:41:34  southa
# Item handling
#
# Revision 1.19  2006/10/17 15:27:59  southa
# Player collisions
#
# Revision 1.18  2006/10/16 15:25:57  southa
# Explosion lifetimes
#
# Revision 1.17  2006/10/15 17:12:53  southa
# Scripted explosions
#
# Revision 1.16  2006/10/14 16:59:43  southa
# Ruby Deco objects
#
# Revision 1.15  2006/10/08 11:31:31  southa
# Hit points
#
# Revision 1.14  2006/10/02 17:25:03  southa
# Object lookup and target selection
#
# Revision 1.13  2006/09/07 10:02:36  southa
# Shader interface
#
# Revision 1.12  2006/08/25 01:44:56  southa
# Khazi fire
#
# Revision 1.11  2006/08/24 13:04:37  southa
# Event handling
#
# Revision 1.10  2006/08/20 14:19:19  southa
# Seek operation
#
# Revision 1.9  2006/08/17 08:57:10  southa
# Event handling
#
# Revision 1.8  2006/08/01 17:21:16  southa
# River demo
#
# Revision 1.7  2006/08/01 13:41:11  southa
# Pre-release updates
#

require 'Mushware.rb'
require 'AdanaxisAI.rb'
require 'AdanaxisAIKhazi.rb'
require 'AdanaxisAIKhaziAttendant.rb'
require 'AdanaxisAIKhaziCarrier.rb'
require 'AdanaxisAIKhaziHarpik.rb'
require 'AdanaxisAIKhaziInert.rb'
require 'AdanaxisAIKhaziLimescale.rb'
require 'AdanaxisAIKhaziRail.rb'
require 'AdanaxisAIKhaziWarehouse.rb'
require 'AdanaxisAIProjectile.rb'
require 'AdanaxisDashboard.rb'
require 'AdanaxisEffects.rb'
require 'AdanaxisEvents.rb'
require 'AdanaxisFontLibrary.rb'
require 'AdanaxisGame.rb'
require 'AdanaxisLogic.rb'
require 'AdanaxisMagazine.rb'
require 'AdanaxisMaterialLibrary.rb'
require 'AdanaxisMenu.rb'
require 'AdanaxisMeshLibrary.rb'
require 'AdanaxisPiece.rb'
require 'AdanaxisPieceDeco.rb'
require 'AdanaxisPieceEffector.rb'
require 'AdanaxisPieceItem.rb'
require 'AdanaxisPieceKhazi.rb'
require 'AdanaxisPieceLibrary.rb'
require 'AdanaxisPiecePlayer.rb'
require 'AdanaxisPieceProjectile.rb'
require 'AdanaxisRemnant.rb'
require 'AdanaxisRender.rb'
require 'AdanaxisShaderLibrary.rb'
require 'AdanaxisSpace.rb'
require 'AdanaxisTargetSelect.rb'
require 'AdanaxisTextureLibrary.rb'
require 'AdanaxisTriggeredEvent.rb'
require 'AdanaxisUtil.rb'
require 'AdanaxisVTools.rb'
require 'AdanaxisWaveLibrary.rb'
require 'AdanaxisWeapon.rb'
require 'AdanaxisWeaponLibrary.rb'
