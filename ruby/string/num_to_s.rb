# Pair programming partner: Rob Andrews

def num_to_s(num, base)
  str = ''
  letter_digits = {10 => "A", 11 => "B", 12 => "C", 13 => "D", 14 => "E", 15 => "F"}
  divisor = 1
  until divisor > num
    bit = (num / divisor) % base
    if bit >= 10
      bit = letter_digits[bit]
    end
    str << bit.to_s
    divisor *= base
  end
  str.reverse
end
