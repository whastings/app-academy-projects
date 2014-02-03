# Pair programming partner: Alexander Bryan

# TODO: Make sure it handles unable to make change.
# TODO: Would be great to be able to beat `make_change(23, [10, 5, 4])`
#       Should return: [10, 5, 4, 4]

def make_change_helper(change, coin_array)
  return [] if change == 0
  if coin_array.length == 1
    if change == coin_array.first
      return [coin_array.first]
    else
      return nil
    end
  end
  return_change = []
  coin_array.each_with_index do |coin, index|
    result = nil
    if coin <= change
      result = make_change_helper(change-coin,coin_array)
    else # coin can no longer make change.
      new_coins = coin_array.dup
      new_coins.delete_at(index)
      result = make_change_helper(change,new_coins)
    end
    unless result.nil?
      return_change.concat(result)
      return_change << coin if coin <= change
      break
    end
  end
  return_change.sort
end

def make_change(change, original_coins)
  original_coins = original_coins.sort
  coin_array = original_coins.reverse
  change_combos = {}
  original_coins.length.times do
    combo = make_change_helper(change, coin_array)
    change_combos[combo.length] = combo
    coin_array.unshift(coin_array.pop)
  end
  change_combos = change_combos.sort { |a, b| b <=> a }
  p change_combos
  change_combos[-1][1]
end
