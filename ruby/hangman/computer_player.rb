# Pair programming partner: Kiran Surdhar

class ComputerPlayer < Player

  def initialize
    super
    @completed_guesses = []
  end

  def file_name=(file_name)
    @dictionary = File.read(file_name).split("\n")
  end

  def recieve_secret_length(length)
    super(length)
    @recieved_length = length
    @dictionary.reject { |word| word != length }
  end

  def guess
    guess = most_frequent_letter
    @completed_guesses << guess
    guess
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    recieve_secret_length(@secret_word.length)
    @secret_word.length
  end

  def check_guess(guess)
    input = []
    @secret_word.split('').each_with_index do |character, index|
      input << index if guess == character
    end
    update_status(guess, input)
    input
  end

  def handle_guess_response(positions)
    puts "unfiltered dictionary length = #{@dictionary.length}"
    @dictionary.reject! do |word|
      !check_word?(word, @completed_guesses.last, positions)
    end
    puts "filtered dictionary length = #{@dictionary.length}"
  end

  def shake_hands
    "#{@secret_word.capitalize} was my secret word."
  end

  def to_s
    "Computer"
  end

  private

  def most_frequent_letter
    # TODO: Break into two methods.
    letters = {}
    @dictionary.join.split('').each do |letter|
      letters[letter] ||= 0
      letters[letter] += 1
    end
    highest_frequency = 0
    best_letter = nil
    letters.each do |letter, count|
      if count > highest_frequency && !@completed_guesses.include?(letter)
        highest_frequency = count
        best_letter = letter
      end
    end
    best_letter
  end

  def check_word?(word, letter, positions)
    word_good = true
    return false if positions.empty? && word.include?(letter)
    positions.each do |position|
      if word[position] != letter
        word_good = false
        break
      end
    end
    word_good
  end
end
