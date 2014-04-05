#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require "scale"
require "set"

# Using Ranges
puts Scale.transform(10).using(-24..24, 0..3.0)

# Using Sets
puts Scale.transform(8).using(Set.new([0, 2, 4, 8, 16, 64]), Set.new([0, 1, 2, 3, 10]))

# Using Arrays
puts Scale.transform(0.5).using([0, 0.5, 3, 7], [0, 2, 4, 8, 12, 16, 32, 64, 128, 512])

# Using mixed methods
puts Scale.transform(0.40).using(0..1, [512, 128, 64, 32, 16, 12, 8, 4, 2, 0])
