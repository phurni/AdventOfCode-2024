# AoC-2024 Day 11 part 2

def blink(stone)
  if stone == '0'
    ['1']
  elsif stone.size.even?
    stone.split(/(?<=\A.{#{stone.size/2}})/).map {|s| s.to_i.to_s }
  else
    [(stone.to_i * 2024).to_s]
  end
end

stones = ARGF.read.split.each_with_object({}) {|stone, memo| memo[stone] = 1 }
transformations = (1..75).reduce(stones) do |transformations|
  transformations.each_with_object(Hash.new(0)) do |(stone, count), memo|
    blink(stone).each { |new_stone| memo[new_stone] += count }
  end
end
puts transformations.values.sum
