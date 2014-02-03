# Pair programming partner: Rob Andrews

class HanoiTower

  def initialize(num_disks)
    @towers = [[], [], []]
    num_disks.downto(1) { |i| @towers.first << i }
  end

  def move(start_tower, end_tower)
    if valid_move?(start_tower, end_tower)
      @towers[end_tower - 1] << @towers[start_tower - 1].pop
      @towers
    else
      "Invalid move. Try again."
    end
  end

  def game_over
    if @towers[0].empty? && @towers[1].empty?
      puts "YOU WIN"
      return true
    end
    false
  end

  def valid_move?(start_tower, end_tower)
    start_tower = @towers[start_tower - 1]
    end_tower = @towers[end_tower - 1]
    if !start_tower.empty? && (end_tower.empty? || start_tower.last < end_tower.last)
      return true
    end
    false
  end
end


if __FILE__ == $PROGRAM_NAME
  tower = HanoiTower.new(5)
  until tower.game_over
    puts "Enter move sequence [move_from, move_to]:\n"
    moves = gets.chomp
    moves = moves.split(",")
    moves.map! { |x| x.to_i }
    p tower.move(*moves)
  end
end
