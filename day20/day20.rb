# AoC-2024 Day 20 both parts

require 'matrix'

DIRECTIONS = [Vector[-1, 0], Vector[0, 1], Vector[1, 0], Vector[0, -1]]

map = Matrix.rows(ARGF.each_line(chomp: true).map(&:chars))
start_pos = Vector[*map.index('S')]
map[*map.index('E')] = '.'

distances = {start_pos => 0}
waves = [start_pos]
until waves.empty?
  pos = waves.shift
  DIRECTIONS.each do |dir|
    tried_pos = pos + dir
    next unless map[*tried_pos] == '.'
    map[*tried_pos] = 'x'
    distances[tried_pos] = distances[pos] + 1
    waves << tried_pos
  end
end

deltas = distances.to_a.combination(2).filter_map do |(pos1, dist1), (pos2, dist2)|
  delta = (pos2-pos1).map(&:abs).sum
  delta if dist2 - dist1 - delta >= 100
end

puts deltas.count(2)
puts deltas.count {|delta| delta <= 20 }
