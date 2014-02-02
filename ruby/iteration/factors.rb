# Pair programming partner: Samantha Eng

def factors(number)
  1.upto(number) do |possible_factor|
    puts possible_factor if number % possible_factor == 0
  end
end

factors(24)
