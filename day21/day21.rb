# AoC-2024 Day 21 both parts

NUMPAD = "789456123 0A".chars.each_with_index.each_with_object({}) {|(button, idx), memo| memo[button] = [idx % 3, idx / 3] }
DIRPAD = " ^A<v>".chars.each_with_index.each_with_object({}) {|(button, idx), memo| memo[button] = [idx % 3, idx / 3] }

def steps(pad, sequence, score_count = 1)
  start_pos = pad['A']
  forbidden_pos = pad[' ']
  sequence.chars.each_with_object(Hash.new(0)) do |button, memo|
    target_pos = pad[button]
    flag = (target_pos[0] == forbidden_pos[0] && start_pos[1] == forbidden_pos[1]) || (target_pos[1] == forbidden_pos[1] && start_pos[0] == forbidden_pos[0])
    memo[[target_pos[0] - start_pos[0], target_pos[1] - start_pos[1], flag]] += score_count
    start_pos = target_pos
  end
end

def sequence_size(code, robots_count)
  moves = steps(NUMPAD, code)
  0.upto(robots_count) do
    moves = moves.reduce(Hash.new(0)) do |memo, ((x, y, flag), count)|
      buttons = [['<', -x], ['v', y], ['^', -y], ['>', x]].reduce('') {|memo, (button, times)| memo + button * [times, 0].max }
      memo.merge!(steps(DIRPAD, (flag ? buttons.reverse : buttons) + 'A', count)) {|_, ca, cb| ca + cb }
    end
  end
  moves.values.sum
end

codes = ARGF.readlines(chomp: true)
puts codes.sum {|code| sequence_size(code, 2) * code.to_i }
puts codes.sum {|code| sequence_size(code, 25) * code.to_i }
