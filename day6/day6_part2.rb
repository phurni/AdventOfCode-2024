# AoC-2024 Day 6 part 2

require 'matrix'

DIRECTIONS = {'^' => Vector[-1, 0], '>' => Vector[0, 1], 'v' => Vector[1, 0], '<' => Vector[0, -1]}

def inside?(map, position)
  position[0] >= 0 && position[0] < map.row_count &&
  position[1] >= 0 && position[1] < map.column_count
end

def walk_map(map, position, obstruction_position = nil)
  walked_positions = Hash.new {|hash, key| hash[key] = Set.new }

  directions = DIRECTIONS.cycle
  direction = directions.next

  loop do
    # Cycle detected if we have already been at this position with the same direction
    return nil if walked_positions[position].include? direction.first

    walked_positions[position] << direction.first
    next_position = position + direction.last

    # Leaving the room?
    return walked_positions.keys unless inside?(map, next_position)

    if next_position == obstruction_position || map[*next_position] == "#"
      direction = directions.next
    else
      position = next_position
    end
  end
end

map = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]
initial_position = Vector[*map.index('^')]

puts walk_map(map, initial_position).count {|position| walk_map(map, initial_position, position).nil? }
