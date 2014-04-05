#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require "scale/core_ext"
require "set"

puts 10.scaled.using(-24..24, 0..3.0)
puts 8.scaled_using([0, 2, 4, 8, 16, 64], [0, 1, 2, 3, 10])
puts 0.5.scaled_from([0, 0.5, 3, 7]).to([0, 2, 4, 8, 12, 16, 32, 64, 128, 512])
puts 0.40.scaled.from(0..1).to([512, 128, 64, 32, 16, 12, 8, 4, 2, 0])
puts -16.scaled.to(-5..-3.0).from(-24..-12)
puts -18.scaled_to(-5..-3.0).from(-24..-12)

