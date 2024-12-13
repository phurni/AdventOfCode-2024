# AoC-2024 Day 1 part 1

puts ARGF.readlines.map {|line| line.split.map(&:to_i) }.count {|report| report.each_cons(2).map {|a, b| a - b }.yield_self {|deltas| (deltas.all?(&:negative?) || deltas.all?(&:positive?)) && deltas.all? {|delta| delta.abs <= 3 } } }
