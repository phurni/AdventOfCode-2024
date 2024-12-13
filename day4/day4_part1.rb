# AoC-2024 Day 4 part 1

matrix = ARGF.readlines(chomp: true).map(&:chars)
padding = matrix.size.times.map {|size| Array.new(size) }
puts [
  matrix,
  matrix.transpose,
  padding.zip(matrix).zip(padding.reverse).map(&:flatten).transpose,
  padding.reverse.zip(matrix).zip(padding).map(&:flatten).transpose,
].sum {|oriented_matrix| oriented_matrix.sum {|line| line.join.scan("XMAS").size + line.join.scan("SAMX").size } }
