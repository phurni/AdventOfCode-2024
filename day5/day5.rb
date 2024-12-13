# AoC-2024 Day 5 both parts

rules, updates = ARGF.read.split("\n\n")
rules = rules.each_line.map {|line| line.split("|").map(&:to_i) }
updates = updates.each_line.map {|line| line.split(",").map(&:to_i) }

correct_ordering = ->(update) do
  update.each_with_index.all? do |page, index|
    (update[0...index] - rules.filter_map {|before, after| before if after == page }).empty? &&
    (update[index+1..-1] - rules.filter_map {|before, after| after if before == page }).empty?
  end
end

# Part 1
puts updates.select(&correct_ordering).sum {|update| update[update.size / 2] }

# Part 2
fixed_updates = updates.reject(&correct_ordering).map do |update|
  update.sort_by {|page| (rules.filter_map {|before, after| before if after == page } & update).size }
end
puts fixed_updates.sum {|update| update[update.size / 2] }
