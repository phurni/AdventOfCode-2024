# AoC-2024 Day 9 part 1

diskmap = ARGF.read.chars.each_slice(2).each_with_object([]).with_index {|((file_size, free_size), memo), index| memo.concat(Array.new(file_size.to_i, index)).concat(Array.new(free_size.to_i)) }

# Far better way, takes only ~0.4 seconds
blocks = diskmap.compact
compacted_diskmap = diskmap.first(diskmap.size - diskmap.count(nil)).map {|file_id| file_id || blocks.pop }
puts compacted_diskmap.each_with_index.sum {|(file_id, block_position)| file_id.to_i * block_position }

# Naive way (like on the subject description, takes huge amount of time ~10 minutes)
diskmap.count(nil).times do
  block_position = diskmap.rindex(&:itself)
  diskmap[diskmap.index(nil)] = diskmap[block_position]
  diskmap[block_position] = nil
end
puts diskmap.each_with_index.sum {|(file_id, block_position)| file_id.to_i * block_position }
