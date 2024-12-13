# AoC-2024 Day 4 part 2

require 'matrix'

matrix = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]
total = (0..matrix.row_size - 3).to_a.product((0..matrix.column_size - 3).to_a).count do |row_index, column_index|
  minor = matrix.minor(row_index, 3, column_index, 3)
  diagonal_word = minor.map(:diagonal).to_a.join
  anti_diagonal_word = Matrix[*minor.to_a.map(&:reverse)].map(:diagonal).to_a.join
  diagonal_word =~ /MAS|SAM/ && anti_diagonal_word =~ /MAS|SAM/
end
puts total

__END__

matrix = Matrix[*ARGF.readlines(chomp: true).map(&:chars)]
total = (0..matrix.column_size - 3).sum do |column_index|
  (0..matrix.row_size - 3).count do |row_index|
    minor = matrix.minor(row_index, 3, column_index, 3)
    diagonal_word = minor.map(:diagonal).to_a.join
    anti_diagonal_word = Matrix[*minor.to_a.map(&:reverse)].map(:diagonal).to_a.join
    diagonal_word =~ /MAS|SAM/ && anti_diagonal_word =~ /MAS|SAM/
  end
end
puts total
