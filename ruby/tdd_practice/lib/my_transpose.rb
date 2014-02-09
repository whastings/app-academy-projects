def my_transpose(array)
  Array.new(array.first.length).zip(*array).map(&:compact)
end