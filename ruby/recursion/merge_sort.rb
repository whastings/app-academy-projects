# Pair programming partner: Alexander Bryan

def merge_sort(array_to_sort)
  return array_to_sort if array_to_sort.length == 1

  left_elements = array_to_sort.slice!(0...(array_to_sort.length / 2))
  left_merge = merge_sort(left_elements)
  right_merge = merge_sort(array_to_sort)

  sorter(left_merge, right_merge)
end

def sorter(array1, array2)
  merged_array = []
  if array1.empty?
    return array2
  elsif array2.empty?
    return array1
  end

  if array1[0] < array2[0]
    merged_array << array1.shift
  else
    merged_array << array2.shift
  end
  merged_array.concat(sorter(array1, array2))
end
