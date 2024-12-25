# AoC-2024 Day 25 part 1

require 'matrix'

locks, keys = ARGF.read.split("\n\n").partition {|item| item[0] == '#' }
locks.map! {|lock| Vector.elements(lock.split("\n").map(&:chars).transpose.map {|column| column.count('#') }, false) }
keys.map! {|key| Vector.elements(key.split("\n").map(&:chars).transpose.map {|column| column.count('.') }, false) }

puts locks.sum {|lock| keys.count {|key| !(key - lock).any?(&:negative?) } }
