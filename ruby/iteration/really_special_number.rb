# Pair programming partner: Samantha Eng

def really_special_number
  current_number = 0
  loop do
    break if current_number > 250 && current_number % 7 == 0
    current_number += 1
  end
  puts current_number
  current_number
end

really_special_number
