# AoC-2024 Day 13 part 2

machines = ARGF.read.split("\n\n")

winning_token_counts = machines.filter_map do |machine|
  ax, ay, bx, by, px, py = machine.scan(/\d+/).map(&:to_i)
  px += 10_000_000_000_000
  py += 10_000_000_000_000

  b_count = (py * ax - px * ay) / (by * ax - bx * ay).to_f
  a_count = (px - bx * b_count) / ax.to_f
  a_count * 3 + b_count if (a_count % 1 == 0) && (b_count % 1 == 0)
end

puts winning_token_counts.sum
