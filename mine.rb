require 'yaml'

class Tile

  attr_accessor :pos, :bomb, :revealed, :flag, :board

  TILE_OFFSETS = [
    [1, 0],
    [0, 1],
    [1, 1],
    [-1, 1],
    [1, -1],
    [-1, 0],
    [0, -1],
    [-1, -1]
  ]

  def initialize(x, y, game)
    @pos = [x, y]
    @bomb = false
    @flag = false
    @revealed = false
    @board = game.board
  end

  def reveal
    return if @flag
    @revealed = true
    bombs_nearby = neighbor_bomb_count
    return true if bombs_nearby > 0
    near_neighbors = neighbors
    near_neighbors.reject! { |neighbor| neighbor.revealed }
    near_neighbors.each { |neighbor| neighbor.reveal }
  end

  def neighbors
    neighbor_tiles = []
    x, y = @pos
    TILE_OFFSETS.each do |x2, y2|
      if (0..8).cover?(x + x2) && (0..8).cover?(y + y2)
        neighbor_tiles << self.board[y + y2][x + x2]
      end
    end
    neighbor_tiles
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each do |neighbor|
      count += 1 if neighbor.bomb
    end
    count
  end

  def status
    return "F" if @flag

    if @revealed == false
      return "*"
    else
      return "$" if @bomb
      return "_" if neighbor_bomb_count == 0
      return neighbor_bomb_count
    end

  end

end


class Minesweeper
  attr_accessor :board, :time

  def initialize(start_board = nil)
    if start_board.nil?
      @board = Array.new(9){ Array.new}
      @board.each_with_index do |row, index|
        9.times do |col_index|
          row << Tile.new(col_index, index, self)
        end
      end
      puts_bombs
      @time = 0
    else
      load_board(start_board)
    end
  end

  def puts_bombs
    bombs = []

    @board.flatten.sample(10).each{ |tile|tile.bomb = true }

    # until bombs.length == 10
    #     row = (0..8).to_a.sample
    #     column = (0..8).to_a.sample
    #     unless bombs.include? [row,column]
    #       @board[row][column].bomb = true
    #       bombs << [row,column]
    #     end
    #   end

  end

  def save_board
    puts "Name of file?"
    File.open("#{gets.chomp}.txt", "w") { |f| f.puts self.to_yaml }
  end

  def expand(position)
    x, y = position
    if @board[y][x].bomb
      lost
      return false
    end

    @board[y][x].reveal

    true
  end

  def flag(position)
    x, y = position
    tile = @board[y][x]
    # tile.flag ? tile.flag = false : tile.flag = true
    tile.flag = !tile.flag
  end

  def display
    printout = @board.flatten.map do |tile|
      tile.status
    end
    count = 0
    another_count = 0
    puts "  0 1 2 3 4 5 6 7 8"
    printout.each do |char|
      if count == 0
        print "#{another_count} "
        another_count += 1
      end
      print "#{char} "
      count += 1
      if count == 9
        puts
        count = 0
      end
    end
    nil
  end

  def user_input(input)
    position = input.split(",").map { |char| char =~ /\d/ ? char.to_i : char.downcase }
    case position.first
    when "f"
      flag(position.drop(1))
    when "q"
      puts "You Loser!"
      return false
    when "s"
      @time += (Time.now - @start_time).to_f
      save_board
    when "l"
      puts "Load file?"
      load_board(gets.chomp)
    else
      return expand(position)
    end
    true
  end

  def load_board(filename)
    saved_game = YAML.load(File.read("#{filename}.txt"))
    @board = saved_game.board
    @time = saved_game.time
  end

  def won?
    tiles = @board.flatten.reject { |tile| tile.bomb }
    tiles.all?(&:revealed)
  end

  def lost
    show_all_bombs
    display
    puts "Game over!"
  end

  def play
    @start_time = Time.now
    while true
      display
      puts "Enter your choice (i.e. 1,1) or flag using F,1,2"
      puts "q for quit, l for load, s for save:"
      break unless user_input(gets.chomp)
      if won?
        puts "You win!"
        break
      end
    end
    @time += (Time.now - @start_time).to_f
    puts "Time taken: #{@time}"
    display_leader_board if won?
  end

  def show_all_bombs
    @board.flatten.each { |tile| tile.revealed = true if tile.bomb }
  end

  def display_leader_board
    leader = Leaderboard.new(@time)
    leader.check_time
    leader.save
    leader.display
  end

end

class Leaderboard
  def initialize(time)
    contents = File.read("leaderboard.txt")
    @top_scores = contents.empty? ? {} : YAML.load(contents)
    @new_time = time
  end

  def check_time
    qualifies = false
    if @top_scores.keys.length <= 10
      qualifies = true
    else
      last_key = @top_scores.keys.last
      if @top_scores[last_key] > @new_time
        @top_scores.delete(last_key)
        qualifies = true
      end
    end
    if qualifies
      puts "Your name?"
      @top_scores[gets.chomp] = @new_time
    end
    @top_scores = @top_scores.sort_by { |person, time| time }
  end

  def save
    File.open("leaderboard.txt", "w") { |f| f.puts @top_scores.to_yaml }
  end

  def display
    puts "Top Scores:"
    @top_scores.each { |name, time| puts "#{name} - #{time}"}
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new(ARGV.shift)
  game.play
end
