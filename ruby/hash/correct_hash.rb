# Pair programming partner: Rob Andrews

def correct_hash(hash)
  temp = {}
  hash.each do |key, value|
    letter = value.chr.to_sym
    temp[letter] = value
  end
  temp
end
