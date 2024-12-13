# AoC-2024 Day 1 both parts

left_list, right_list = ARGF.readlines.map {|line| line.split.map(&:to_i)}.transpose

# Part 1
puts left_list.sort.zip(right_list.sort).map {|left, right| (left - right).abs }.sum

# Part 2
puts left_list.sum {|value| right_list.count(value) * value }
