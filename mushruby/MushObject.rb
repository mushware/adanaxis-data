#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushObject.rb
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
#%Header } uObEJ2GwOzNQn1HHses5Ew
# $Id: MushObject.rb,v 1.1 2006/10/14 16:59:43 southa Exp $
# $Log: MushObject.rb,v $
# Revision 1.1  2006/10/14 16:59:43  southa
# Ruby Deco objects
#

class MushObject
  def self.mush_reader(*inArgs)
    inArgs.each do |arg|
      argName = arg.to_s
      
      if argName.sub!(/^m_/, "m")
        argName[1, 1] = argName[1, 1].upcase
      end
      class_eval(<<-EOS, __FILE__, __LINE__+1)
        def #{argName}
          @#{arg}
        end
EOS
    end
  end

  def self.mush_writer(*inArgs)
    inArgs.each do |arg|
      argName = arg.to_s
      
      if argName.sub!(/^m_/, "m")
        argName[1, 1] = argName[1, 1].upcase
      end
      class_eval(<<-EOS, __FILE__, __LINE__+1)
        def #{argName}Set(inParam)
          @#{arg} = inParam
        end
EOS
    end
  end
  
  def self.mush_accessor(*inArgs)
    mush_reader(*inArgs)
    mush_writer(*inArgs)
  end
end
