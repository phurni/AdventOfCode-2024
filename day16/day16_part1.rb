# AoC-2024 Day 16 part 1

require 'matrix'

map = Matrix.rows(ARGF.each_line(chomp: true).map(&:chars))
start_pos = Vector[*map.index('S')]
end_pos = Vector[*map.index('E')]
map[*end_pos] = '.'

score = 0
waves = [[start_pos, score, Vector[0, 1]]]
found = until waves.empty?
  best_wave = waves.min_by {|wave| wave[1] }
  pos, score, dir = waves.delete(best_wave)
  break true if pos == end_pos
  [[dir, 1], [dir.cross, 1001], [-dir.cross, 1001]].each do |tried_dir, score_amount|
    tried_pos = pos + tried_dir
    next unless map[*tried_pos] == '.'
    map[*tried_pos] = 'x'
    waves.push([tried_pos, score + score_amount, tried_dir])
  end
end

puts score if found
