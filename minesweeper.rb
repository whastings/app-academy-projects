require './tile'
require './leaderboard'

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
