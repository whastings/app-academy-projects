# Pair programming partner: Samantha Eng

def bubble_sort(array)
  original_array = array.dup
  (0...array.length).each do |index|
    next if array[index + 1].nil?
    if array[index + 1] < array[index]
      array[index], array[index + 1] = array[index + 1], array[index]
    end
  end
  if original_array == array
    array
  else
    bubble_sort(array)
  end
end
