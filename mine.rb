class Tile

  attr_accessor :pos, :bomb

  def initialize(x, y)
    @pos = [x, y]
    @bomb = false
    @flag = false
    @revealed = false
  end

  def reveal(board)
    @revealed = true

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

    if @revealed = false
      return "*"
    else
      return "$" if @bomb
      return "_" if neighbor_bomb_count(board) == 0
      return neighbor_bomb_count(board)
    end

  end

end


class Minesweeper
  attr_accessor :board, :revealed

  def initialize
    @board = Array.new(9) { |ind| Array.new(9) { |sec_ind| Tile.new(ind, sec_ind) } }
    @revealed = []
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
    return false if @board[x][y]

    @board[x][y].reveal(@board)


  end

  def display
    "#{board[0][1].status}
  end

end
