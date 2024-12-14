# AoC-2024 Day 12 both parts

require 'matrix'

DIRECTIONS = [Vector[-1, 0], Vector[0, 1], Vector[1, 0], Vector[0, -1]]
VISITED = Set.new

def fetch(map, position)
  return nil unless position[0] >= 0 && position[0] < map.row_count && position[1] >= 0 && position[1] < map.column_count
  map[*position]
end

def flood_fill(map, position, plant, dir)
  if fetch(map, position) != plant
    if fetch(map, position + dir.cross) == plant || fetch(map, position + dir.cross + dir.cross.cross) != plant
      return Vector[0, 1, 1]
    else
      return Vector[0, 1, 0]
    end
  end
  return Vector[0, 0, 0] if VISITED.include? position
  VISITED << position
  DIRECTIONS.reduce(Vector[1, 0, 0]) do |memo, direction|
    memo + flood_fill(map, position + direction, plant, direction)
  end
end

map = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]
metrics = map.each_with_index.filter_map do |plant, row, column|
  next if VISITED.include? Vector[row, column]
  plant = map[row, column]
  flood_fill(map, Vector[row, column], plant, 0)
end

puts metrics.reduce(0) {|memo, metric| memo + metric[0] * metric[1] }
puts metrics.reduce(0) {|memo, metric| memo + metric[0] * metric[2] }
