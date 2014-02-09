def pick_stocks(prices)
  max = 0
  days = []
  (0...prices.length - 1).each do |first_day|
    (first_day + 1...prices.length).each do |second_day|
      if prices[second_day] - prices[first_day] > max
        days = [first_day, second_day]
        max = prices[second_day] - prices[first_day]
      end
    end
  end
  days
end