# AoC-2024 Day 24 part 1

OPERATIONS = {
  'AND' => ->(op1, op2) { op1 & op2 },
  'OR'  => ->(op1, op2) { op1 | op2 },
  'XOR' => ->(op1, op2) { op1 ^ op2 },
}

initials, wirings = ARGF.read.split("\n\n")
wirings = wirings.scan(/^(\w+) (\w+) (\w+) -> (\w+)$/).each_with_object({}) {|(op1, operator, op2, target), memo| memo[target] = [op1, operator, op2] }

gates = Hash.new do |hash, key|
  left, operator, right = wirings.fetch key
  hash[key] = OPERATIONS[operator].call(hash[left], hash[right])
end
initials.scan(/^(\w+): (\d)$/).each {|name, value| gates[name] = value.to_i }

puts (0..).lazy.map {|bit| gates["z#{'%02d' % bit}"] rescue nil }.take_while(&:itself).to_a.reverse.map(&:to_s).join.to_i(2)
