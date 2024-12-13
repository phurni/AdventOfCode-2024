# AoC-2024 Day 2 both parts

def safe_levels?(report)
  deltas = report.each_cons(2).map {|a, b| a - b }
  (deltas.all?(&:negative?) || deltas.all?(&:positive?)) && deltas.all? {|delta| delta.abs <= 3 }
end

def safe_with_bad?(report)
  (0...report.size).any? {|index_candidate| safe_levels?(report.reject.with_index {|_, index| index == index_candidate }) }
end

reports = ARGF.readlines.map {|line| line.split.map(&:to_i) }

# Part 1
puts reports.count {|report| safe_levels?(report) }

# Part 2
puts reports.count {|report| safe_levels?(report) || safe_with_bad?(report) }
