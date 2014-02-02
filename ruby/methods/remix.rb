def remix(drinks)
  alcohols, mixers = divide_drinks(drinks)
  mixers = rearrange(mixers)
  mix_drinks(alcohols, mixers)
end

def divide_drinks(drinks)
  alcohols = []
  mixers = []
  drinks.each do |alcohol, mixer|
    alcohols << alcohol
    mixers << mixer
  end
  [alcohols, mixers]
end

def mix_drinks(alcohols, mixers)
  drinks = []
  alcohols.length.times do |drink_index|
    drinks << [alcohols[drink_index], mixers[drink_index]]
  end
  drinks
end

def rearrange(liquids)
  shuffled_liquids = liquids.shuffle
  until all_different?(liquids, shuffled_liquids)
    shuffled_liquids = liquids.shuffle
  end
  shuffled_liquids
end

def all_different?(original, remixed)
  original.each_with_index do |liquid, index|
    return false if remixed[index] == liquid
  end
  true
end