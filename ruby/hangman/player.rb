# Pair programming partner: Kiran Surdhar

class Player
  attr_reader :status

  def initialize
    @status = []
  end

  def visualize
    puts
    puts "Secret word: #{@status.join(" ")}"
    puts
  end

  def recieve_secret_length(length)
    length.times { @status << "_" }
  end

  protected

  def update_status(guess, positions)
    return if positions.empty?
    positions.each { |position| @status[position] = guess }
  end
end
