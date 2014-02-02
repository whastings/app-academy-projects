# Redo of word chains solo.

def adjacent_words(word, dictionary)
  words = []
  (0...word.length).each do |char_index|
    ("a".."z").each do |new_char|
      next if new_char == word[char_index]
      new_word = word.dup
      new_word[char_index] = new_char
      words << new_word if dictionary.include?(new_word)
    end
  end
  words
end
