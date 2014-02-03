class Tile

  attr_accessor :pos, :bomb, :revealed, :flag

  def initialize(x, y)
    @pos = [x, y]
    @bomb = false
    @flag = false
    @revealed = false
  end

  def reveal(board)
    @revealed = true
    bombs_nearby = neighbor_bomb_count(board)
    return true if bombs_nearby > 0
    near_neighbors = neighbors(board)
    near_neighbors.reject! { |neighbor| neighbor.revealed }
    near_neighbors.each { |neighbor| neighbor.reveal(board) }
  end

  def neighbors(board)
    neighbor_tiles = []
    x, y = @pos
    [ [1, 0], [0, 1], [1, 1], [-1, 1], [1, -1], [-1, 0], [0, -1], [-1, -1] ].each do |x2, y2|
      if (0..8).cover?(x + x2) && (0..8).cover?(y + y2)
        neighbor_tiles << board[x + x2][y + y2]
      end
    end
    neighbor_tiles
  end

  def neighbor_bomb_count(board)
    count = 0
    neighbors(board).each do |neighbor|
      count += 1 if neighbor.bomb
    end
    count
  end

  def status(board)
    return "F" if @flag

    if @revealed == false
      return "*"
    else
      return "$" if @bomb
      return "_" if neighbor_bomb_count(board) == 0
      return neighbor_bomb_count(board)
    end

  end

end


class Minesweeper
  attr_accessor :board

  def initialize
    @board = Array.new(9) { |ind| Array.new(9) { |sec_ind| Tile.new(ind, sec_ind) } }
    puts_bombs
  end

  def puts_bombs
    bombs = []

    until bombs.length == 10
      row = (0..8).to_a.sample
      column = (0..8).to_a.sample
      unless bombs.include? [row,column]
        @board[row][column].bomb = true
        bombs << [row,column]
      end
    end

  end

  def expand(position)
    x, y = position
    return false if @board[x][y].bomb

    @board[x][y].reveal(@board)

    true
  end

  def flag(position)
    x, y = position
    tile = @board[x][y]
    tile.flag ? tile.flag = false : tile.flag = true
  end

  def display
    printout = @board.flatten.map do |tile|
      tile.status(self.board)
    end
    count = 0
    printout.each do |char|
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
    input.split(",").map { |char| char =~ /\d/ ? char.to_i : char }
  end

  def play
    while true
      display
      puts "Enter your choice (i.e. 1,1) or flag using F,1,2:"
      position = user_input(gets.chomp)
      if position.first =~ /f/i
        flag(position.drop(1))
      else
        unless expand(position)
          show_all_bombs
          display
          puts "Game over!"
          break
        end
      end
    end
  end

  def show_all_bombs
    @board.flatten.each { |tile| tile.revealed = true if tile.bomb }
  end

end
