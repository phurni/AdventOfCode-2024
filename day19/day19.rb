# AoC-2024 Day 19 part 1

patterns, designs = ARGF.read.split("\n\n")
patterns = patterns.split(', ')
designs = designs.split("\n")

puts designs.grep(Regexp.new("^(#{patterns.sort_by {|pattern| [-pattern.size, pattern] }.join('|')})+$")).size
