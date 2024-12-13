# AoC-2024 Day 6 part 1

require 'matrix'

def inside?(map, position)
  position[0] >= 0 && position[0] < map.row_count &&
  position[1] >= 0 && position[1] < map.column_count
end

map = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]
position = Vector[*map.index('^')]

directions = [Vector[-1, 0], Vector[0, 1], Vector[1, 0], Vector[0, -1]].cycle
direction = directions.next

loop do
  map[*position] = "X"
  next_position = position + direction
  break unless inside?(map, next_position)
  if map[*next_position] == "#"
    direction = directions.next
  else
    position = next_position
  end
end

puts map.count("X")
