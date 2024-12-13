# AoC-2024 Day 11 part 1

def blink(stones)
  stones.flat_map do |stone|
    if stone == '0'
      '1'
    elsif stone.size.even?
      stone.split(/(?<=\A.{#{stone.size/2}})/).map {|s| s.to_i.to_s }
    else
      (stone.to_i * 2024).to_s
    end
  end
end

stones = ARGF.read.split
25.times { stones = blink(stones) }
puts stones.size
