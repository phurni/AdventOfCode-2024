# AoC-2024 Day 10 both parts

require 'matrix'

DIRECTIONS = [Vector[-1, 0], Vector[0, 1], Vector[1, 0], Vector[0, -1]]

def inside?(map, position)
  position[0] >= 0 && position[0] < map.row_count &&
  position[1] >= 0 && position[1] < map.column_count
end

def trailup(map, position, level)
  return nil unless inside?(map, position) && map[*position] == level
  return position if level == '9'
  DIRECTIONS.flat_map do |direction|
    trailup(map, position + direction, level.succ)
  end.compact
end

map = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]
part_countings = [->(trailhead) { trailup(map, trailhead, '0').uniq.size }, ->(trailhead) { trailup(map, trailhead, '0').size }]
part_countings.each do |part_counting|
  puts map.each_with_index.filter_map {|item, row, column| Vector[row, column] if item == '0' }.sum(&part_counting)
end
