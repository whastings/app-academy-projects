# Pair programming partner: Alexander Bryan

def subsets full_array
  return [[]] if full_array.empty?
  old_stuff = subsets full_array[0...-1]
  new_stuff = old_stuff.map{ |old_sub_set| old_sub_set.dup.push(full_array.last) }
  old_stuff + new_stuff
end
