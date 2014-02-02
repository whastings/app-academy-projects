# Pair programming partner: Alexander Bryan

class Array

  def my_each (&blk)
    index = 0
    while index < self.length
      blk.call(self[index])
      index+=1
    end
    self
  end


  def my_map (&blk)
    [].tap do |mapped_array|
      self.my_each { |element| mapped_array << blk.call(element)}
    end
  end

  def my_select (&blk)
    [].tap do |mapped_array|
      self.my_each {|element| mapped_array << element if blk.call(element)}
    end
  end

  def my_inject(&blk)
    current_value = self.first
    self[1..-1].my_each {|element| current_value = blk.call(current_value, element)}
    current_value
  end

  def my_sort!(&blk)
    sorted = false
    until sorted
      index, sorted = 0, true
      while index < (self.length - 1)
        if blk.call(self[index], self[index + 1]) == 1
          self[index], self[index + 1] = self[index + 1], self[index]
          sorted = false
        end
        index += 1
      end
    end
    self
  end

end
