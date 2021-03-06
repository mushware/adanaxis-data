#%Header {
##############################################################################
#
# File adanaxis-data/ruby/AdanaxisPieceLibrary.rb
#
# Copyright: Andy Southgate 2002-2007, 2020
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
##############################################################################
#%Header } 4D5qSCA+PSCut0IY/Z3gIA
# $Id: AdanaxisPieceLibrary.rb,v 1.30 2007/06/27 12:58:11 southa Exp $
# $Log: AdanaxisPieceLibrary.rb,v $
# Revision 1.30  2007/06/27 12:58:11  southa
# Debian packaging
#
# Revision 1.29  2007/06/14 12:14:15  southa
# Level 30
#
# Revision 1.28  2007/06/08 16:23:03  southa
# Level 26
#
# Revision 1.27  2007/06/06 12:24:13  southa
# Level 22
#
# Revision 1.26  2007/06/05 12:15:13  southa
# Level 21
#
# Revision 1.25  2007/05/29 13:25:56  southa
# Level 20
#
# Revision 1.24  2007/05/23 19:14:58  southa
# Level 18
#
# Revision 1.23  2007/05/22 16:44:58  southa
# Level 18
#
# Revision 1.22  2007/05/10 11:44:11  southa
# Level15
#
# Revision 1.21  2007/05/08 15:28:13  southa
# Level 12
#
# Revision 1.20  2007/05/01 16:40:06  southa
# Level 10
#
# Revision 1.19  2007/04/26 13:12:39  southa
# Limescale and level 9
#
# Revision 1.18  2007/04/21 09:41:05  southa
# Level work
#
# Revision 1.17  2007/04/20 12:07:08  southa
# Khazi Warehouse and level 8
#
# Revision 1.16  2007/04/18 09:21:53  southa
# Header and level fixes
#
# Revision 1.15  2007/04/17 21:16:33  southa
# Level work
#
# Revision 1.14  2007/03/28 14:45:46  southa
# Level and AI standoff
#
# Revision 1.13  2007/03/27 15:34:42  southa
# L4 and carrier ammo
#
# Revision 1.12  2007/03/27 14:01:02  southa
# Attendant AI
#
# Revision 1.11  2007/03/24 18:07:22  southa
# Level 3 work
#
# Revision 1.10  2007/03/24 14:06:28  southa
# Cistern AI
#
# Revision 1.9  2007/03/23 18:39:08  southa
# Carriers and spawning
#
# Revision 1.8  2007/03/23 12:27:34  southa
# Added levels and Cistern mesh
#
# Revision 1.7  2007/03/21 11:56:05  southa
# Rail effects and damage icons
#
# Revision 1.6  2007/03/20 20:36:54  southa
# Solid renderer fixes
#
# Revision 1.5  2007/03/13 18:21:36  southa
# Scanner jamming
#
# Revision 1.4  2007/03/13 12:22:50  southa
# Scanner symbols
#
# Revision 1.3  2007/03/06 21:05:17  southa
# Level work
#
# Revision 1.2  2007/03/06 11:34:00  southa
# Space and precache fixes
#
# Revision 1.1  2007/02/08 17:55:12  southa
# Common routines in space generation
#

class AdanaxisPieceLibrary < MushObject
  def initialize(inParams = {})
    @m_targetDefault = 'p'
    @m_typeDefault = 'k'

    diff = AdanaxisRuby.cGameDifficulty

    @m_droneDefaults = {
      :effect_scale => 0.5,
      :hit_points => 1.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziInert
    }
    @m_droneNum = 0

    @m_attendantDefaults = {
      :effect_scale => 1.0,
      :hit_points => 10.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziAttendant,
      :ai_state_msec => 3000,
      :ai_state => :evade,
      :evade_speed => 0.05*(1+diff),
      :evade_acceleration => 0.01*(1+diff),
      :seek_speed => 0.05*(1+diff),
      :seek_acceleration => 0.01*(1+diff),
      :seek_stand_off => 20.0,
      :weapon => :khazi_base
    }
    @m_attendantNum = 0

    @m_bleachDefaults = {
      :effect_scale => 10.0,
      :hit_points => 250.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziBleach,
      :ai_state_msec => 3000,
      :ai_state => :evade,
      :evade_speed => 0.05*(1+diff),
      :evade_acceleration => 0.01*(1+diff),
      :seek_speed => 0.2,
      :seek_acceleration => 0.005,
      :seek_stand_off => 200.0,
      :weapon => :khazi_nuclear
    }
    @m_bleachNum = 0

    @m_cisternDefaults = {
      :effect_scale => 2.5,
      :hit_points => 50.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziCarrier,
      :ai_state_msec => 6000,
      :ai_state => :patrol,
      :patrol_speed => 0.08,
      :patrol_acceleration => 0.002,
      :ram_speed => 0.1 + 0.1*diff,
      :ram_acceleration => 0.005 + 0.002*diff,
      :seek_speed => 0.0,
      :seek_acceleration => 0.0,
      :weapon => :attendant_spawner,
      :ammo_count => 10 + 10 * diff
    }
    @m_cisternNum = 0

    @m_doorDefaults = {
      :effect_scale => 10.0,
      :hit_points => 1000.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziInert,
      :ai_state_msec => 60000,
      :ai_state => :dormant
    }
    @m_doorNum = 0

    @m_floaterDefaults = {
      :effect_scale => 4.0,
      :hit_points => 40.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziFloater,
      :ai_state_msec => 1000,
      :ai_state => :dormant,
      :seek_speed => 0.2*(1+diff),
      :seek_acceleration => 0.01*(1+diff)
    }
    @m_floaterNum = 0

    @m_freshenerDefaults = {
      :effect_scale => 3.0,
      :hit_points => 45.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziInert,
      :ai_state_msec => 1000,
      :ai_state => :dormant,
      :is_jammer => true
    }
    @m_freshenerNum = 0

    @m_harpikDefaults = {
      :effect_scale => 1.0,
      :hit_points => 25.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziHarpik,
      :ai_state_msec => 8000,
      :ai_state => :seek,
      :evade_speed => 0.1*(1+diff),
      :evade_acceleration => 0.03*(1+diff),
      :seek_speed => 0.1*(1+diff),
      :seek_acceleration => 0.02*(1+diff),
      :seek_stand_off => 50.0,
      :weapon => :khazi_harpik_long
    }
    @m_harpikNum = 0

    @m_hubDefaults = {
      :effect_scale => 30.0,
      :hit_points => 3000.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziInert,
      :ai_state_msec => 60000,
      :ai_state => :dormant
    }
    @m_hubNum = 0

    @m_limescaleDefaults = {
      :effect_scale => 3.5,
      :hit_points => 60.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziLimescale,
      :ai_state_msec => 8000,
      :ai_state => :seek,
      :evade_speed => 0.2*(1+diff),
      :evade_acceleration => 0.02*(1+diff),
      :seek_speed => 0.2*(1+diff),
      :seek_acceleration => 0.02*(1+diff),
      :seek_stand_off => 200.0,
      :weapon => :khazi_limescale
    }
    @m_limescaleNum = 0

    @m_vendorDefaults = {
      :effect_scale => 1.0,
      :hit_points => 30.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziVendor,
      :ai_state_msec => 3000,
      :ai_state => :evade,
      :evade_speed => 0.05*(1+diff),
      :evade_acceleration => 0.01*(1+diff),
      :seek_speed => 0.05*(1+diff),
      :seek_acceleration => 0.01*(1+diff),
      :seek_stand_off => 50.0,
      :weapon => :khazi_light_missile
    }
    @m_vendorNum = 0

    @m_vortexDefaults = {
      :effect_scale => 5.0,
      :hit_points => 100.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziVortex,
      :ai_state_msec => 3000,
      :ai_state => :evade,
      :evade_speed => 0.05*(1+diff),
      :evade_acceleration => 0.01*(1+diff),
      :seek_speed => 0.05*(1+diff),
      :seek_acceleration => 0.01*(1+diff),
      :seek_stand_off => 300.0,
      :weapon => :khazi_flush
    }
    @m_vortexNum = 0

    @m_warehouseDefaults = {
      :effect_scale => 2.0,
      :hit_points => 40.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziWarehouse,
      :ai_state_msec => 1000,
      :ai_state => :dormant,
      :evade_speed => 0.01*(1+diff),
      :evade_acceleration => 0.003*(1+diff),
      :seek_speed => 0.05,
      :seek_acceleration => 0.01,
      :seek_stand_off => 50.0
    }
    @m_warehouseNum = 0

    @m_railDefaults = {
      :effect_scale => 5.0,
      :hit_points => 160.0,
      :type => @m_typeDefault,
      :ai_object => AdanaxisAIKhaziRail,
      :ai_state_msec => 8000,
      :ai_state => :evade,
      :evade_speed => 0.02*(1+diff),
      :evade_acceleration => 0.006*(1+diff),
      :seek_speed => 0.01*(1+diff),
      :seek_acceleration => 0.003*(1+diff),
      :override_dead_msec => 20000,
      :patrol_speed => 0.01*(1+diff),
      :patrol_acceleration => 0.003*(1+diff),
      :remnant => :player_rail,
      :weapon => :khazi_rail
    }
    @m_railNum = 0

  end

  # Derive target type from input parameters
  def mTargetTypes(inParams)
    retVal = @m_targetDefault

    case inParams[:colour]
      when 'red'
        retVal = 'kb+p,'
      when 'blue'
        retVal = 'kr'
    end
    retVal
  end

  # Derive piece type from input parameters
  def mType(inParams)
    retVal = @m_typeDefault

    case inParams[:colour]
      when 'red'
        retVal = 'kr'
      when 'blue'
        retVal = 'kb'
    end
    retVal += 'p' if inParams[:is_primary];
    retVal
  end

  def mScannerSymbol(inParams)
    retVal = AdanaxisScanner::SYMBOL_KHAZI_PLAIN
    isPrimary = inParams[:is_primary] || false
    isPower = (inParams[:hit_points] && inParams[:hit_points] > 60.0)
    hasRemnant = inParams[:remnant]

    case inParams[:colour]
      when 'red'
        if isPrimary
          retVal = AdanaxisScanner::SYMBOL_PRIMARYKHAZI_RED
        elsif isPower
          retVal = AdanaxisScanner::SYMBOL_POWERKHAZI_RED
        elsif hasRemnant
          retVal = AdanaxisScanner::SYMBOL_CARRIERKHAZI_RED
        else
          retVal = AdanaxisScanner::SYMBOL_KHAZI_RED
        end

      when 'blue'
        if isPrimary
          retVal = AdanaxisScanner::SYMBOL_PRIMARYKHAZI_BLUE
        elsif isPower
          retVal = AdanaxisScanner::SYMBOL_POWERKHAZI_BLUE
        elsif hasRemnant
          retVal = AdanaxisScanner::SYMBOL_CARRIERKHAZI_BLUE
        else
          retVal = AdanaxisScanner::SYMBOL_KHAZI_BLUE
        end
    end
    retVal
  end

  def mCommonCreate(inPiece, inParams = {})
    if inParams[:spawned]
      # Create a flare for spawned pieces
      $currentLogic.mEffects.mExplode(
        :post => inPiece.mPost,
        :embers => 0,
        :explosions => 0,
        :flares => 1,
        :flare_scale_range => (20.0..25.0),
        :flare_lifetime_range => (600..700)
      )
      # MushGame.cSoundPlay("spawning sound", mPost)
    end
  end

  # Creates a Drone
  def mDroneCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mDroneParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_droneNum += 1
  end

  # Creates an Attendant
  def mAttendantCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mAttendantParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_attendantNum += 1
  end

  # Creates a Bleach
  def mBleachCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mBleachParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_bleachNum += 1
  end

  # Creates a Cistern
  def mCisternCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mCisternParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_cisternNum += 1
  end

  # Creates a Door
  def mDoorCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mDoorParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_doorNum += 1
  end

  # Creates a Floater
  def mFloaterCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mFloaterParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_floaterNum += 1
  end

  # Creates a Freshener
  def mFreshenerCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mFreshenerParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_freshenerNum += 1
  end

  # Creates a Harpik
  def mHarpikCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mHarpikParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_harpikNum += 1
  end

  # Creates a Hub
  def mHubCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mHubParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_hubNum += 1
  end

  # Creates a Limescale
  def mLimescaleCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mLimescaleParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_limescaleNum += 1
  end

  # Creates a Vendor
  def mVendorCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mVendorParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_vendorNum += 1
  end

  # Creates a Vortex
  def mVortexCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mVortexParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_vortexNum += 1
  end

  # Creates a Warehouse
  def mWarehouseCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mWarehouseParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_warehouseNum += 1
  end

  # Creates a Rail
  def mRailCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    newPiece = AdanaxisPieceKhazi.cCreate(mRailParams(inParams))
    mCommonCreate(newPiece, inParams)
    @m_railNum += 1
  end

  def mDroneTex(*inColours)
    return inColours.collect { |name| "drone-#{name}-tex" }
  end

  def mAttendantTex(*inColours)
    return inColours.collect { |name| "attendant-#{name}-tex" }
  end

  def mBleachTex(*inColours)
    return inColours.collect { |name| "bleach-#{name}-tex" }
  end

  def mCisternTex(*inColours)
    return inColours.collect { |name| "cistern-#{name}-tex" }
  end

  def mDoorTex(*inColours)
    return inColours.collect { |name| "door-#{name}-tex" }
  end

  def mFloaterTex(*inColours)
    return inColours.collect { |name| "floater-#{name}-tex" }
  end

  def mFreshenerTex(*inColours)
    return inColours.collect { |name| "freshener-#{name}-tex" }
  end

  def mHarpikTex(*inColours)
    return inColours.collect { |name| "harpik-#{name}-tex" }
  end

  def mHubTex(*inColours)
    return inColours.collect { |name| "hub-#{name}-tex" }
  end

  def mLimescaleTex(*inColours)
    return inColours.collect { |name| "limescale-#{name}-tex" }
  end

  def mVendorTex(*inColours)
    return inColours.collect { |name| "vendor-#{name}-tex" }
  end

  def mVortexTex(*inColours)
    return inColours.collect { |name| "vortex-#{name}-tex" }
  end

  def mWarehouseTex(*inColours)
    return inColours.collect { |name| "warehouse-#{name}-tex" }
  end

  def mRailTex(*inColours)
    return inColours.collect { |name| "rail-#{name}-tex" }
  end

protected
  # Add parameters common to all pieces, e.g. position
  def mKhaziAddBaseParams(ioParams, inParams)
    ioParams[:post] = MushPost.new(:position => inParams[:position]) if inParams[:position]
  end

  # Derive parameters for a Drone
  def mDroneParams(inParams = {})

    # Start with the defaults
    retParams = @m_droneDefaults.dup

    # Choose a mesh name based on the colour
    retParams[:mesh_name] = 'drone'

    # Derive type and target types, i.e. what this is and what it shoots at
    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)

    # Select the remnant left behind when rhe craft is destroyed
    retParams[:remnant] = $currentLogic.mRemnant.mLowGradeRemnant(@m_attendantNum)

    # Set scanner symbol.  Needs to know remnant type, hence merge
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))

    # Add paramters common to all pieces, i.e. position
    mKhaziAddBaseParams(retParams, inParams)

    # Merge the input parameters so that they overwrite those we've calculated
    retParams.merge!(inParams)

    retParams
  end

  # Derive parameters for an Attendant
  def mAttendantParams(inParams = {})

    # Start with the defaults
    retParams = @m_attendantDefaults.dup

    # Choose a mesh name based on the colour
    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "attendant-#$1"
      when nil then          "attendant"
      else raise "Unknown attendant colour #{inParams[:colour]}"
    end

    # Derive type and target types, i.e. what this is and what it shoots at
    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)

    # Select the remnant left behind when rhe craft is destroyed
    retParams[:remnant] = $currentLogic.mRemnant.mLowGradeRemnant(@m_attendantNum)

    # Set scanner symbol.  Needs to know remnant type, hence merge
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))

    # Add paramters common to all pieces, i.e. position
    mKhaziAddBaseParams(retParams, inParams)

    # Merge the input parameters so that they overwrite those we've calculated
    retParams.merge!(inParams)

    retParams
  end

  # Derive parameters for a Bleach
  def mBleachParams(inParams = {})

    retParams = @m_bleachDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "bleach-#$1"
      when nil then          "bleach"
      else raise "Unknown bleach colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = :player_nuclear
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  # Derive parameters for a Cistern
  def mCisternParams(inParams = {})

    # Start with the defaults
    retParams = @m_cisternDefaults.dup

    # Choose a mesh name based on the colour
    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "cistern-#$1"
      when nil then          "cistern"
      else raise "Unknown cistern colour #{inParams[:colour]}"
    end

    # Derive type and target types, i.e. what this is and what it shoots at
    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)

    # Select the remnant left behind when rhe craft is destroyed
    retParams[:remnant] = $currentLogic.mRemnant.mMediumGradeRemnant(@m_cisternNum)

    # Set scanner symbol.  Needs to know remnant type, hence merge
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))

    # Add paramters common to all pieces, i.e. position
    mKhaziAddBaseParams(retParams, inParams)

    # Merge the input parameters so that they overwrite those we've calculated
    retParams.merge!(inParams)

    retParams
  end

  # Derive parameters for a Door
  def mDoorParams(inParams = {})

    retParams = @m_doorDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "door-#$1"
      when nil then          "door"
      else raise "Unknown door colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = :player_nuclear
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  # Derive parameters for a Floater
  def mFloaterParams(inParams = {})

    retParams = @m_floaterDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "floater-#$1"
      when nil then          "floater"
      else raise "Unknown floater colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = $currentLogic.mRemnant.mMediumGradeRemnant(@m_floaterNum)
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  # Derive parameters for a Freshener
  def mFreshenerParams(inParams = {})

    retParams = @m_freshenerDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "freshener-#$1"
      when nil then          "freshener"
      else raise "Unknown freshener colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = $currentLogic.mRemnant.mMediumGradeRemnant(@m_freshenerNum)
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  # Derive parameters for a Harpik
  def mHarpikParams(inParams = {})

    # Start with the defaults
    retParams = @m_harpikDefaults.dup

    # Choose a mesh name based on the colour
    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "harpik-#$1"
      when nil then          "harpik"
      else raise "Unknown harpik colour #{inParams[:colour]}"
    end

    # Derive type and target types, i.e. what this is and what it shoots at
    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)

    # Select the remnant left behind when rhe craft is destroyed
    retParams[:remnant] = $currentLogic.mRemnant.mMediumGradeRemnant(@m_harpikNum)

    # Set scanner symbol.  Needs to know remnant type, hence merge
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))

    # Add paramters common to all pieces, i.e. position
    mKhaziAddBaseParams(retParams, inParams)

    # Merge the input parameters so that they overwrite those we've calculated
    retParams.merge!(inParams)

    retParams
  end

    # Derive parameters for a Hub
  def mHubParams(inParams = {})

    retParams = @m_hubDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "hub-#$1"
      when nil then          "hub"
      else raise "Unknown hub colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = :player_nuclear
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  def mLimescaleParams(inParams = {})
    retParams = @m_limescaleDefaults.dup
    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "limescale-#$1"
      when nil then          "limescale"
      else raise "Unknown limescale colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)

    retParams[:remnant] = :player_heavy_cannon

    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))

    mKhaziAddBaseParams(retParams, inParams)

    retParams.merge!(inParams)

    retParams
  end

  def mVendorParams(inParams = {})
    retParams = @m_vendorDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "vendor-#$1"
      when nil then          "vendor"
      else raise "Unknown vendor colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = :player_light_missile
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  def mVortexParams(inParams = {})
    retParams = @m_vortexDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "vortex-#$1"
      when nil then          "vortex"
      else raise "Unknown vortex colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = :player_flush
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  # Derive parameters for a Warehouse
  def mWarehouseParams(inParams = {})

    retParams = @m_warehouseDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "warehouse-#$1"
      when nil then          "warehouse"
      else raise "Unknown warehouse colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = $currentLogic.mRemnant.mMediumGradeRemnant(@m_warehouseNum)
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end

  def mRailParams(inParams = {})

    retParams = @m_railDefaults.dup

    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/ then "rail-#$1"
      when nil then          "rail"
      else raise "Unknown rail colour #{inParams[:colour]}"
    end

    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = :player_rail
    retParams[:scanner_symbol] = mScannerSymbol(retParams.merge(inParams))
    mKhaziAddBaseParams(retParams, inParams)
    retParams.merge!(inParams)
    retParams
  end
end
