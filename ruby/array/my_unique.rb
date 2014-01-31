# Pair programming partner: Rob Andrews

class Array

  def my_uniq
    temp = []
    each do |item|
      next if temp.include?(item)
      temp << item
    end
    temp
  end

end
