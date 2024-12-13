# AoC-2024 Day 13 part 1

machines = ARGF.read.split("\n\n")

winning_token_counts = machines.filter_map do |machine|
  ax, ay, bx, by, px, py = machine.scan(/\d+/).map(&:to_i)

  b_count = (py * ax - px * ay) / (by * ax - bx * ay).to_f
  a_count = (px - bx * b_count) / ax.to_f
  a_count * 3 + b_count if a_count <= 100 && b_count <= 100 && (a_count % 1 == 0) && (b_count % 1 == 0)
end

puts winning_token_counts.sum
