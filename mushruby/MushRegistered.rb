#%Header {
##############################################################################
#
# File adanaxis-data/mushruby/MushRegistered.rb
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
#%Header } Vz/RHgMAqHl0M5QdgAglhA

module MushRegistered
  def mushRegistered_install
    class_eval(<<-EOS, __FILE__, __LINE__+1)
      @@registeredObjects = {}
      def self.cRegisteredCreate(params=nil)
        object = params ? new(params) : new
        
        if @@registeredObjects.has_key?(object_id)
          puts "Attempt to register object twice \#{object.object_id} => \#{object.inspect}"
        end
        
        @@registeredObjects[object.object_id] = object
        #puts "Registering \#{object.object_id}"
        object
      end
  
      def mRegisteredDestroy
        #puts "Unregistering \#{self.object_id}"
        unless @@registeredObjects.has_key?(object_id)
          raise RuntimeError, "Attempt to destroy unregistered object \#{self.object_id} => \#{self.inspect}"
        end
        @@registeredObjects.delete object_id
        # GC.start if $MUSHCONFIG['DEBUG']
      end
    EOS
  end
end

