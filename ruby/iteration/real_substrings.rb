# Pair programming partner: Samantha Eng

require "./substrings"

def real_substrings(str)
  dictionary = File.read("dictionary.txt").split("\n")
  substrings(str).select { |substring| dictionary.include?(substring) }
end
