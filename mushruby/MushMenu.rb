#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushMenu.rb
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
#%Header } KgPvoyD+iJ9DRopdz3TkrQ
# $Id: MushMenu.rb,v 1.11 2007/03/13 21:45:03 southa Exp $
# $Log: MushMenu.rb,v $
# Revision 1.11  2007/03/13 21:45:03  southa
# Release process
#
# Revision 1.10  2007/03/07 11:29:22  southa
# Level permission
#
# Revision 1.9  2006/11/08 18:30:53  southa
# Key and axis configuration
#
# Revision 1.8  2006/08/01 17:21:13  southa
# River demo
#
# Revision 1.7  2006/08/01 13:41:07  southa
# Pre-release updates
#

class MushMenu
  MENU_STRING = 0
  MENU_SYMBOL = 1
  MENU_PARAM = 2
  MENU_FLAGS = 3
  
  YCOORD_DEFAULT = 0.22
  YCOORD_CENTRE = -0.18
  
  def initialize(params)
    @title = params[:title]
    @menu = params[:menu]
    @font = MushGLFont.new(:name => 'library-font1');
    @size = params[:size] || 0.02
    @spacing = params[:spacing] || 1.2
    @current = 0
    @colour = params[:colour] || MushVector.new(1,1,1,0.3)
    @highlight_colour = params[:highlight_colour] || MushVector.new(1,1,1,1)
    @m_grey_colour = params[:grey_colour] || MushVector.new(1,1,1,0.1)
    @title_colour = params[:title_colour] || MushVector.new(1,1,1,1)
    @yCoord = YCOORD_DEFAULT
    @leftright = params[:leftright] || false
  end

  attr_accessor :title, :menu, :font, :size, :spacing, :current, :colour, :highlight_colour, :title_colour, :leftright

  def mRender(msec)
    xCoord = -0.42
    
    newYCoord = @current * @size * @spacing + YCOORD_CENTRE
    newYCoord = YCOORD_DEFAULT if newYCoord < YCOORD_DEFAULT
    
    @yCoord = 0.875 * @yCoord + 0.125 * newYCoord
    yCoord = @yCoord
    
    if @title
      @font.colour = @title_colour      
      @font.mRenderAtSize(@title, xCoord, yCoord, @size)
      yCoord -= @size * @spacing * 1.2
    end
    
    @menu.each_index do |i|
      item = @menu[i]
      
      if item[MENU_FLAGS] && item[MENU_FLAGS][:grey]
        @font.colour = @m_grey_colour
      elsif i == @current
        @font.colour = @highlight_colour
      else
        @font.colour = @colour      
      end

      @font.mRenderAtSize(item[MENU_STRING], xCoord, yCoord, @size)
      yCoord -= @size * @spacing
    end
  end

  def mLeft(obj)
    if @leftright && @current < @menu.size
      symbol = @menu[@current][MENU_SYMBOL]
      obj.send(symbol, @menu[@current][MENU_PARAM], -1)
    end
  end
  
  def mRight(obj)
    if @leftright && @current < @menu.size
      symbol = @menu[@current][MENU_SYMBOL]
      obj.send(symbol, @menu[@current][MENU_PARAM], 1)
    end
  end
  
  def mUp
    @menu.size.times do
      @current = (@current + @menu.size - 1) % @menu.size
      item = @menu[@current]
      break unless item[MENU_FLAGS] && item[MENU_FLAGS][:grey]
    end
  end
    
  def mDown
    @menu.size.times do
      @current = (@current + 1) % @menu.size
      item = @menu[@current]
      break unless item[MENU_FLAGS] && item[MENU_FLAGS][:grey]
    end
  end
    
  def mEnter(obj)

    if @current < @menu.size
      symbol = @menu[@current][MENU_SYMBOL]
      obj.send(symbol, @menu[@current][MENU_PARAM], 0)
    end
  end

  def mKeypress(obj, inKey)
    if (@current < @menu.size)
      symbol = @menu[@current][MENU_SYMBOL]
      obj.send(symbol, inKey, @menu[@current][MENU_PARAM])
    end
  end
  
end
  
