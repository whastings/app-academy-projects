require 'dispel'

class HumanPlayer

  def initialize(board)
    @board = board
    @cursor_position = [0, 0]
  end

  def board_string
    board_string = @board.display_board
    board_array = board_string.split("\n")
    board_array.map! do |line|
      chars = line.split('')
      new_chars = []
      chars.each do |char|
        new_chars << ' ' + char
      end
      new_chars.join
    end
    board_array[@cursor_position.last][@cursor_position.first + 1] = "\u25A2"
    board_array.join("\n")
  end

  def move_cursor(x_offset, y_offset)
    current_x, current_y = @cursor_position
    new_x = current_x + x_offset
    new_y = current_y + y_offset
    @cursor_position = [new_x, new_y]
  end

  def play_turn
    positions = []
    Dispel::Screen.open do |screen|
      screen.draw board_string
      Dispel::Keyboard.output do |key|
        break if key == "q"
        case key
        when :up then move_cursor(0,-1)
        when :down then move_cursor(0,1)
        when :right then move_cursor(2,0)
        when :left then move_cursor(-2,0)
        when :enter
          positions << [@cursor_position.first / 2, @cursor_position.last]

          sleep(1)
          break if positions.length == 2
        end
        screen.draw board_string
      end
    end
    return positions
  end

end

