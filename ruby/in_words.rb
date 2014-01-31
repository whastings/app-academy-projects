# Pair programming partner: Rob Andrews

class Fixnum

  ONES = { 0=> "zero", 1=> "one", 2=> "two", 3=> "three", 4=> "four", 5=> "five", 6=> "six", 7=> "seven", 8=> "eight", 9=> "nine" }
  TEENS = { 10=>"ten", 11=> "eleven", 12=> "twelve", 13=> "thirteen", 14=> "fourteen", 15=> "fifteen", 16=> "sixteen", 17=> "seventeen", 18=> "eighteen", 19=> "nineteen" }
  TENS = { 20=> "twenty", 30=> "thirty", 40=> "forty", 50=> "fifty", 60=> "sixty", 70=> "seventy", 80=> "eighty", 90=> "ninety" }
  MAGNITUDE = [ "thousand", "million", "billion", "trillion", "quadrillion" ] # "quintillion", "sextillion", "septillion", "octillion" will work if you extend Integer class to include Bignum

  def in_words
    return "zero" if self == 0
    num_parts = split_num
    words = []
    num_parts.each_with_index do |num_part, idx|
      temp=''
      temp += translate(num_part)
      temp += ' ' + MAGNITUDE[idx - 1] if idx > 0 && !temp.empty?
      words << temp
    end
    words.reject!{|w| w.empty?}
    words.reverse.join(' ').strip
  end

  private

  def split_num
    num_parts=[]
    num_str = to_s.reverse
    idx = 0
    while idx < num_str.length
      num_parts << num_str[idx..(idx+2)].reverse
      idx+=3
    end
    num_parts
  end

  def translate(part)
    part=part.to_i
    return '' if part == 0
    return translate_tens(part) if part < 100
    words = []
    hundreds_place = (part / 100)
    words << "#{ONES[hundreds_place]} hundred"
    words << translate_tens(part % 100)
    words.join(" ").strip
  end

  def translate_tens(num)
    return '' if num == 0
    return ONES[num] if ONES[num]
    return TEENS[num] if TEENS[num]
    return TENS[num] if TENS[num]
    ones_place = num % 10
    num /= 10
    tens_place = (num % 10) * 10
    "#{TENS[tens_place]} #{ONES[ones_place]}"
  end

end
