# AoC-2024 Day 18 part 1

require 'matrix'

DIRECTIONS = [Vector[-1, 0], Vector[0, 1], Vector[1, 0], Vector[0, -1]]

def fetch(map, position)
  return nil unless position[0] >= 0 && position[0] < map.row_count && position[1] >= 0 && position[1] < map.column_count
  map[*position]
end

dimension = 71
count = 1024

bytes = ARGF.readlines.map {|line| line.scan(/(\d+),(\d+)/).first.map(&:to_i) }
ram = Matrix.build(dimension, dimension) { '.' }
bytes.first(count).each {|x,y| ram[y, x] = '#' }

score = 0
end_pos = Vector[dimension-1, dimension-1]
waves = [[Vector[0, 0], score]]
ram[0, 0] = score

found = until waves.empty?
  pos, score = waves.shift
  break true if pos == end_pos
  DIRECTIONS.each do |tried_dir|
    tried_pos = pos + tried_dir
    next unless fetch(ram, tried_pos) == '.'
    ram[*tried_pos] = score + 1
    waves.push([tried_pos, score + 1])
  end
end

puts score if found
