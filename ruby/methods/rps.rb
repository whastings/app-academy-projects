
def rps(player_move)
  computer_move = make_move
  outcome = determine_outcome(player_move, computer_move)
  "#{computer_move}, #{outcome.to_s.capitalize}"
end

def make_move
  %w{Rock Paper Scissors}.sample
end

def determine_outcome(move1, move2)
  if move1 == move2
    :draw
  elsif winning_moves[move1] == move2
    :lose
  else
    :win
  end
end

def winning_moves
  {
    "Rock" => "Paper",
    "Paper" => "Scissors",
    "Scissors" => "Rock"
  }
end