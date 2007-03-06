#%Header {
##############################################################################
#
# File data-adanaxis/ruby/AdanaxisPieceLibrary.rb
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
#%Header } txNtx34pY3FGnAXYnq2bwA
# $Id: AdanaxisPieceLibrary.rb,v 1.2 2007/03/06 11:34:00 southa Exp $
# $Log: AdanaxisPieceLibrary.rb,v $
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
  
    @m_attendantDefaults = {
      :hit_points => 10.0,
      :type => @m_typeDefault,
      :seek_speed => 0.05,
      :seek_acceleration => 0.01,
    }
    @m_attendantNum = 0
    
    @m_railDefaults = {
      :hit_points => 160.0,
      :type => @m_typeDefault,
      :seek_speed => 0.01,
      :seek_acceleration => 0.003,
      :patrol_speed => 0.01,
      :patrol_acceleration => 0.003,
      :remnant => :player_rail,
      :weapon => :khazi_rail
    }
    @m_railNum = 0

  end

  # Derive target type from input parameters
  def mTargetTypes(inParams)
    retVal = @m_targetDefault
    
    case inParams[:colour]
      when 'red':
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
      when 'red':
        retVal = 'kr'
      when 'blue'
        retVal = 'kb'
    end
    retVal
  end  

  # Creates an Attendant
  def mAttendantCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    AdanaxisPieceKhazi.cCreate(mAttendantParams(inParams))
    @m_attendantNum += 1
  end    

  # Creates a Rail
  def mRailCreate(inParams = {})
    AdanaxisUtil.cSpellCheck(inParams)
    AdanaxisPieceKhazi.cCreate(mRailParams(inParams))
    @m_railNum += 1
  end

  def mAttendantTex(*inColours)
    return inColours.collect { |name| "attendant-#{name}-tex" }
  end

  def mRailTex(*inColours)
    return inColours.collect { |name| "rail-#{name}-tex" }
  end

protected
  # Add parameters common to all pieces, e.g. position
  def mKhaziAddBaseParams(ioParams, inParams)
    ioParams[:post] = MushPost.new(:position => inParams[:position]) if inParams[:position]
  end
  
  # Derive parameters for an Attendant
  def mAttendantParams(inParams = {})
    
    # Start with the defaults
    retParams = @m_attendantDefaults
    
    # Choose a mesh name based on the colour
    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/: "attendant-#$1"
      when nil:          "attendant"
      else raise "Unknown attendant colour #{inParams[:colour]}"
    end
    
    # Derive type and target types, i.e. what this is and what it shoots at
    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    
    # Select the remnant left behind when rhe craft is destroyed
    retParams[:remnant] = $currentLogic.mRemnant.mLowGradeRemnant(@m_attendantNum)
    
    # Add paramters common to all pieces, i.e. position
    mKhaziAddBaseParams(retParams, inParams)
    
    # Merge the input parameters so that they overwrite those we've calculated
    retParams.merge!(inParams)
    
    retParams
  end
  
  def mRailParams(inParams = {})
    
    retParams = @m_railDefaults
    
    retParams[:mesh_name] = case inParams[:colour]
      when /(red|blue)/: "rail-#$1"
      when nil:          "rail"
      else raise "Unknown rail colour #{inParams[:colour]}"
    end
    
    retParams[:type] = mType(inParams)
    retParams[:target_types] = mTargetTypes(inParams)
    retParams[:remnant] = :player_rail
    
    mKhaziAddBaseParams(retParams, inParams)
    
    retParams.merge!(inParams)
    
    retParams
  end
end
