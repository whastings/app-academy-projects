# encoding: utf-8

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
    return "⚐" if @flag

    if @revealed == false
      return "◼"
    else
      return "☀" if @bomb
      return "_" if neighbor_bomb_count == 0
      return neighbor_bomb_count
    end

  end

end
