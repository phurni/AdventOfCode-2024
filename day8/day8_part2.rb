# AoC-2024 Day 8 part 2

require 'matrix'

def inside?(map, position)
  position[0] >= 0 && position[0] < map.row_count &&
  position[1] >= 0 && position[1] < map.column_count
end

map = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]

antennas = Hash.new {|hash, key| hash[key] = [] }
map.each_with_index {|item, row, column| antennas[item] << Vector[row, column] if item =~ /[A-Za-z0-9]/ }

antennas.each do |_, positions|
  positions.combination(2).each do |a, b|
    delta = b - a
    Enumerator.produce(a) {|pos| pos - delta }.take_while {|pos| inside?(map, pos) }.each {|pos| map[*pos] = "_" }
    Enumerator.produce(b) {|pos| pos + delta }.take_while {|pos| inside?(map, pos) }.each {|pos| map[*pos] = "_" }
  end
end

puts map.count {|item| item =~ /\w/ }
