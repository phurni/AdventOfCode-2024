# AoC-2024 Day 17 part 1

registers, program = ARGF.read.split("\n\n")
registers = registers.scan(/\d+/).map(&:to_i)
program = program.sub('Program: ', '').split(',').map(&:to_i)

ip = 0
combo = ->(value) { value < 4 ? value : registers[value - 4] }
instructions = [
  ->(operand) { registers[0] = registers[0] / (2**combo[operand]); ip += 2 },  # adv
  ->(operand) { registers[1] = registers[1] ^ operand; ip += 2 },              # bxl
  ->(operand) { registers[1] = combo[operand] % 8; ip += 2 },                  # bst
  ->(operand) { ip = registers[0].zero? ? ip + 2 : operand },                  # jnz
  ->(operand) { registers[1] = registers[1] ^ registers[2]; ip += 2 },         # bxc
  ->(operand) { print combo[operand] % 8, ','; ip += 2 },                      # out
  ->(operand) { registers[1] = registers[0] / (2**combo[operand]); ip += 2 },  # bdv
  ->(operand) { registers[2] = registers[0] / (2**combo[operand]); ip += 2 },  # cdv
]

while opcode = program[ip]
  instructions[opcode].call(program[ip + 1])
end
