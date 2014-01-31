# Pair programming partner: Rob Andrews

class Array
  def median
    sorted_self = sort
    if length % 2 ==0
      (self[length/2] + self[length/2 - 1]).to_f / 2
    else
      self[length/2]
    end
  end
end
