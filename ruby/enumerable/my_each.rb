# Pair programming partner: Rob Andrews

class Array
  def my_each
    idx = 0
    while idx < length
      yield self[idx]
      idx += 1
    end
    self
  end
end
