# Pair programming partner: Rob Andrews

class Array

  def two_sum
    sums = []
    self.each_with_index do |element, i|
      (i...length).each do |j|
        if (element + self[j] == 0) && i != j
          sums << [i, j].sort
        end
      end
    end
    sums
  end

end
