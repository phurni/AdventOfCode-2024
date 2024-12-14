# AoC-2024 Day 14 part 2

require 'matrix'

robots = ARGF.readlines.map {|line| line.scan(/(-?\d+),(-?\d+)/).map {|x, y| Vector[y.to_i, x.to_i] } }

size = Vector[103, 101]
offset = size.map {|dim| dim / 2 }
original_robots = robots.dup

distances_lifetimes = (1.upto(size[0] * size[1])).map do |lifetime|
  robots.map! {|pos, dir| [(pos + dir).map2(size) {|coord, dim| coord % dim }, dir] }
  # Sum the euclidean distance of each robot to the center of the bathroom, guessing that the xmas tree is centered and made of much of the robots
  distances_sum = robots.reduce(0) {|memo, (pos, _)| memo + (pos - offset).norm }
  [distances_sum, lifetime]
end.sort

# It should be the first which is the one with the least total distance, if not replace the `1` with a higher number to see the other best candidates
distances_lifetimes.first(1).each do |_, lifetime|
  map = Matrix.build(*size) { ' ' }
  original_robots.lazy.map {|pos, dir| (pos + dir * lifetime).map2(size) {|coord, dim| coord % dim } }.each {|pos| map[*pos] = '*' }
  puts "\nMap after #{lifetime} seconds:"
  puts map.to_a.map(&:join)
end
