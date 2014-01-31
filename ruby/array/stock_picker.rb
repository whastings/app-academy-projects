# Pair programming partner: Rob Andrews

def stock_picker(array)
  max = 0
  best_days = nil
  array.each_with_index do |element, index|
    (index...array.length).each do |index2|
      if array[index2] - element > max
        max = array[index2] - element
        best_days = [index, index2]
      end
    end
  end
  best_days
end
