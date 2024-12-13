# AoC-2024 Day 7 both parts

equations = Hash[ARGF.readlines.map {|line| [line[/^\d+/].to_i, line[/: (.+)/, 1].split.map(&:to_i)] }]

# for part 1
operators = [->(a, b) {a + b}, ->(a, b) {a * b}]
# for part 2
operators = [->(a, b) {a + b}, ->(a, b) {a * b}, ->(a, b) {"#{a}#{b}".to_i}]

correct_equations = equations.select do |test_value, numbers|
  Enumerator.product(*Array.new(numbers.size - 1, operators)).find do |operators_combination|
    test_value == numbers.reduce {|memo, number| operators_combination.shift.call(memo, number) }
  end
end
puts correct_equations.keys.sum
