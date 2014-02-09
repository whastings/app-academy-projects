class Array
  def my_uniq
    [].tap do |array|
      self.each do |el|
        array << el unless array.include? el
      end
    end
  end

  def two_sum
    [].tap do |array|
      self.each_with_index do |el, index|
        (index+1...length).each do |endex|
          array << [index, endex] if (el + self[endex] == 0)
        end
      end
    end
  end

end
