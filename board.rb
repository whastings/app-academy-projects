class MoveError < ArgumentError
  attr_reader :start_pos, :end_pos, :piece

  def initialize(message, start_pos, end_pos, piece)
    super(message)
    @start_pos, @end_pos, @piece = start_pos, end_pos, piece
  end

end

class Board
  attr_accessor :board, :kings

  START_POSITION = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  START_ROW = [0, 1, 6, 7]

  def initialize
    @board = Array.new(8){Array.new(8)}
    setup_board
    @kings = { b: @board[0][4], w: @board[7][4] }
  end

  def setup_board
    START_ROW.each do |row|
      color = row > 3 ? :w : :b
      if row == 1 || row == 6
        @board[row].each_index do |index|
          @board[row][index] = Pawn.new([index, row], self, color)
        end
      else
        @board[row].each_index do |index|
          @board[row][index] = START_POSITION[index].new([index, row], self, color)
        end
      end
    end

    @board
  end

  def move(start_pos, end_pos)
    start_x, start_y = start_pos
    end_x, end_y = end_pos
    piece = @board[start_y][start_x]
    if piece.move(end_pos)
      piece.position = end_pos
      @board[start_y][start_x] = nil
      @board[end_y][end_x] = piece
    else
      raise MoveError.new("Can't move there asshole!", start_pos, end_pos, piece)
    end
  end

  def in_check?(color)
    king_position = @kings[color].position
    pieces(color == :b ? :w : :b).each do |piece|
      return true if piece.move(king_position)
    end
    false
  end

  def pieces(color)
    [].tap do |pieces_found|
      @board.each do |row|
        row.each do |piece|
          pieces_found << piece if !piece.nil? && piece.color == color
        end
      end
    end
  end

  def dup
    new_board = Board.new
    check_board = Array.new(8){ [] }
    new_board.board = check_board
    @board.each_with_index do |row, index|
      row.each do |piece|
        duped_piece = (piece.nil? ? nil : piece.dup)
        duped_piece.set_board(new_board) if duped_piece
        check_board[index] << duped_piece
        if piece.is_a?(King)
          new_board.kings[piece.color] = duped_piece
        end
      end
    end

    new_board
  end

  def display_board
    sides = 0
    puts " " + (0..7).to_a.map(&:to_s).join(" ")
    @board.each do |row|
      print sides
      row.each do |piece|
        print piece.nil? ? '- ' : piece
      end
      puts ''
      sides += 1
    end
  end

end
