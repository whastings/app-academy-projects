# Pair programming partner: Alexander Bryan

class Array

  def sum_recursive(index = 0)
    return self[index] if index == (length - 1)
    self[index] + sum_recursive(index + 1)
  end

  def sum_iterative
    sum = 0
    self.each { |x| sum += x }
    sum
  end

end
