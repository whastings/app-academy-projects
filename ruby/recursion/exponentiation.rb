# Pair programming partner: Alexander Bryan

def expo1(base, exponent)
  puts "I ran"
  return 1 if exponent == 0
  base * expo1(base, exponent - 1)
end

def expo2(base, exponent)
  puts "I ran"
  return 1 if exponent == 0
  temp = 0
  if exponent.even?
    temp = expo2(base, exponent / 2)
    temp * temp
  else
    temp = expo2(base, (exponent - 1) / 2)
    base * temp * temp
  end
end
