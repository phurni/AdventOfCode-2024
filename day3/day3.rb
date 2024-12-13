# AoC-2024 Day 3 both parts

memory = ARGF.read

# Part 1
puts memory.scan(/mul\((\d+),(\d+)\)/).map {|(a, b)| a.to_i * b.to_i }.sum

# Part 2
enabled = true
puts memory.scan(/mul\((\d+),(\d+)\)|(don't)\(\)|(do)\(\)/).map {|(a, b, disable, enable)| enabled = enable if disable || enable; enabled ? a.to_i * b.to_i : 0 }.sum
