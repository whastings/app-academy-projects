# Pair programming partner: Rob Andrews

def set_add_el(hash, sym)
  hash[sym] = true
  hash
end

def set_remove_el(hash, sym)
  hash.delete(sym)
  hash
end

def set_list_els(hash)
  hash.keys
end

def set_member?(hash, sym)
  hash.has_key?(sym)
end

def set_union(hash1, hash2)
  hash1.merge(hash2)
end

def set_intersection(hash1, hash2)
  temp = {}
  hash1.each do |key, value|
    if hash2.has_key?(key)
      temp[key] = true
    end
  end
  temp
end

def set_minus(hash1, hash2)
  temp = {}
  hash1.each do |key, value|
    unless hash2.has_key?(key)
      temp[key] = true
    end
  end
  temp
end
