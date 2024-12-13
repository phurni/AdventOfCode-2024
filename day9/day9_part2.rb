# AoC-2024 Day 9 part 2

diskmap = ARGF.read.chars.each_slice(2).each_with_object([]).with_index {|((file_size, free_size), memo), index| memo.concat(Array.new(file_size.to_i, index)).concat(Array.new(free_size.to_i)) }
file_metas = diskmap.each_with_index.chunk_while {|before, after| before.first == after.first }.filter_map {|item| [item[0][0], item[0][1], item.size] if item[0][0] }

file_metas.reverse_each do |id, block_position, size|
  free_space = Array.new(size)
  _, target_position = diskmap.each_cons(size).with_index.find {|candidate, _| candidate == free_space }
  next if target_position.nil? || target_position > block_position

  diskmap[target_position, size] = diskmap[block_position, size]
  diskmap[block_position, size] = free_space
end

puts diskmap.each_with_index.sum {|(file_id, block_position)| file_id.to_i * block_position }
