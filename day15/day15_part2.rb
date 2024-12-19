# AoC-2024 Day 15 part 2

require 'matrix'

DIRECTIONS = {'^' => Vector[-1, 0], '>' => Vector[0, 1], 'v' => Vector[1, 0], '<' => Vector[0, -1]}
EXPANDO = {'#' => '##', 'O' => '[]', '.' => '..', '@' => '@.'}

map, moves = ARGF.read.split("\n\n")
map = Matrix.rows(map.each_line(chomp: true).map {|line| line.chars.map {|char| EXPANDO[char] } })
moves.gsub!(/\s/, '')

position = Vector[*map.index('@')]
map[*position] = '.'

moves.each_char do |move|
  next_position = position + DIRECTIONS[move]
  tile = map[*next_position]

  next if tile == '#'
  next position = next_position if tile == '.'

  # Find the first place that is not a box (either free or wall)
  next_position += DIRECTIONS[move] while map[*next_position] == 'O'
  # Do nothing if we hit a wall
  next if map[*next_position] == '#'
  # Here we just pushed a pile of boxes, so put a box at the tail and free the tile at the head
  map[*next_position] = 'O'
  map[*(position += DIRECTIONS[move])] = '.'
end

puts map.each_with_index.filter_map {|tile, row, column| 100 * row + column if tile == 'O' }.sum
