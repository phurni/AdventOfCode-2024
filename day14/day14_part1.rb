# AoC-2024 Day 14 part 1

require 'matrix'

robots = ARGF.readlines.map {|line| line.scan(/(-?\d+),(-?\d+)/).map {|x, y| Vector[y.to_i, x.to_i] } }

size = Vector[103, 101]
offset = size.map {|dim| dim / 2 }
lifetime = 100

robots_final_positions = robots.map {|pos, dir| (pos + dir * lifetime).map2(size) {|coord, dim| coord % dim } }
robots_positions = robots_final_positions.reject {|pos| pos[0] == offset[0] || pos[1] == offset[1] }
puts robots_positions.group_by {|pos| (pos - offset).map {|coord| coord / coord.abs } }.reduce(1) {|memo, (_, positions)| memo * positions.size }
