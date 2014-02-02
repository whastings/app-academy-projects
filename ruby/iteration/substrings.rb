# Pair programming partner: Samantha Eng

def substrings(str)
  substrings = []
  (0...str.length).each do |starting_index|
    ((starting_index)...str.length).each do |ending_index|
      substrings << str[starting_index..ending_index]
    end
  end
  substrings
end
