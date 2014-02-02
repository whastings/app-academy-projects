class DictionaryGuesser

  def initialize(dictionary)
    @dictionary = dictionary
    @possibilities = dictionary.dup
    @guesses = []
  end

  def guess(state)
    reduce_by_length(state) unless @length
    guesses = most_frequent_letters
    @last_guess = guesses.sample
    @guesses << @last_guess
    @last_guess
  end

  def result=(result)
    if result.nil?
      reduce_by_letter(@last_guess)
    else
      reduce_by_positions(result, @last_guess)
    end
  end

  private

    def reduce_by_length(state)
      @length = state.length
      @possibilities.select! { |word| word.length == @length }
    end

    def reduce_by_letter(letter)
      @possibilities.delete_if { |word| word.include?(letter) }
    end

    def reduce_by_positions(positions, letter)
      @possibilities.select! do |word|
        positions.all? do |position|
          word[position] == letter
        end
      end
    end

    def most_frequent_letters
      letters = {}
      @possibilities.each do |word|
        word.split('').each do |letter|
          letters[letter] ||= 0
          letters[letter] += 1
        end
      end
      frequent_letters, highest_count = [], 0
      letters.each do |letter, count|
        next if @guesses.include?(letter)
        if count == highest_count
          frequent_letters << letter
        elsif count > highest_count
          frequent_letters = [letter]
          highest_count = count
        end
      end
      frequent_letters
    end

    def remove_used_guesses(guesses)
      guesses.delete_if { |guess| @guesses.include?(guess) }
    end

end
