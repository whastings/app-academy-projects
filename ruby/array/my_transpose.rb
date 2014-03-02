# Switch an array's rows with its columns.
#
# Pair programming partner: Rob Andrews

def my_transpose(matrix)
  transpose = Array.new(matrix.length) { [] }
  matrix.each do |subarray|
    subarray.each_with_index do |element, index|
      transpose[index] << element
    end
  end
  transpose
end
