# AoC-2024 Day 23 part 1

require 'set'

bi_connections = ARGF.readlines.map {|line| Set.new(line.scan(/(\w\w)-(\w\w)/).first) }

friends = Hash.new {|hash, key| hash[key] = Set.new }
bi_connections.each do |bi_connection|
  first, second = bi_connection.to_a
  friends[first] << second
  friends[second] << first
end
friends.delete_if {|name, _| name[0] != 't' }

trios = Set.new
friends.each do |name, others|
  bi_connections.each do |bi_connection|
    trios << Set[name].merge(bi_connection) if bi_connection.subset? others
  end
end
puts trios.size
