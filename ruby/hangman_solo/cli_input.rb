class CliInput

  def initialize
    @types = {
      secret_word: 'Please enter the secret word.',
      guess_verification: 'Please check the letter %s',
      guess: 'Please enter a letter guess'
    }
  end

  def get(type, *replacements)
    print_word
    message = @types[type]
    message = message % replacements unless replacements.empty?
    puts message
    gets.chomp
  end

  def word=(word)
    @word = word
  end

  def print_word
    return if @word.nil?
    puts
    @word.split('').each { |char| print "#{char} " }
    puts
    @word.length.times { |i| print (i + 1).to_s + " " }
    puts
  end

end
