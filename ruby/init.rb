
require 'Mushware.rb'
require 'Adanaxis.rb'

$currentGame = AdanaxisGame.new

require 'test/run_tests.rb' if $MUSHCONFIG['DEBUG'] && File.file?('../mushruby/test/run_tests.rb')

