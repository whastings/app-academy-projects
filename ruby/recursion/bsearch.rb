# Pair programming partner: Alexander Bryan

def bsearch(array, target)
  if (array.length == 1)
    return array[0] == target ? 0 : nil
  end

  array = array.sort
  midpoint_index = find_midpoint(array)
  midpoint_element = array[midpoint_index]

  return midpoint_index if midpoint_element == target

  lower_array = array[0...midpoint_index]
  if target < midpoint_element
    bsearch(lower_array, target)
  else
    upper_array = array[(midpoint_index + 1)...array.length]
    upper_result = bsearch(upper_array, target)
    upper_result +=  (lower_array.length + 1) unless upper_result.nil?
  end
end

def find_midpoint(arr)
  arr.length / 2
end
