# AoC-2024 Day 22 part 1

class MonkeyRandom
  def initialize(value)
    @value = value
  end

  def next
    @value = three(two(one(@value)))
  end

  protected

  def one(value)
    (value ^ (value << 6)) & 0xFFFFFF
  end

  def two(value)
    (value ^ (value >> 5)) & 0xFFFFFF
  end

  def three(value)
    (value ^ (value << 11)) & 0xFFFFFF
  end
end

randomizers = ARGF.readlines.map {|value| MonkeyRandom.new(value.to_i) }
randomizers.each {|randomizer| 1999.times { randomizer.next } }
puts randomizers.sum {|randomizer| randomizer.next }
