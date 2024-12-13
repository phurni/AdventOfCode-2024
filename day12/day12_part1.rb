# AoC-2024 Day 12 part 1

require 'matrix'

DIRECTIONS = [Vector[-1, 0], Vector[0, 1], Vector[1, 0], Vector[0, -1]]
VISITED = Set.new

def inside?(map, position)
  position[0] >= 0 && position[0] < map.row_count &&
  position[1] >= 0 && position[1] < map.column_count
end

def flood_fill(map, position, plant)
  return Vector[0, 1] unless inside?(map, position) && map[*position] == plant
  return Vector[0, 0] if VISITED.include? position
  VISITED << position
  DIRECTIONS.reduce(Vector[1, 0]) do |memo, direction|
    memo + flood_fill(map, position + direction, plant)
  end
end

map = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]
metrics = map.each_with_index.filter_map do |plant, row, column|
  next if VISITED.include? Vector[row, column]
  plant = map[row, column]
  flood_fill(map, Vector[row, column], plant)
end

puts metrics.reduce(0) {|memo, metric| memo + metric[0] * metric[1] }
