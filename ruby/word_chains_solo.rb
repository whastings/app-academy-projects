# Redo of word chains solo.

require "set"

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

def words_of_length(word, dictionary)
  candidate_words = Set.new
  dictionary.each do |dictionary_word|
    candidate_words << dictionary_word if word.length == dictionary_word.length
  end
  candidate_words
end

def explore_words(source, dictionary)
  words_to_expand = [source]
  all_reachable_words = Set.new([source])
  candidate_words = words_of_length(source, dictionary)
  until words_to_expand.empty?
    word = words_to_expand.shift
    similar_words = adjacent_words(word, candidate_words)
    candidate_words.subtract(similar_words)
    words_to_expand.concat(similar_words)
    all_reachable_words.merge(similar_words)
  end
  all_reachable_words
end
