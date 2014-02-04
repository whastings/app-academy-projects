# encoding: UTF-8
require "dispel"

class Demo

  def initialize
    @grid = Array.new(5) { Array.new(5) { "_" } }
    @grid[0][0] = "◼"
    @cursor_position = [0, 0]
  end

  def move_cursor(x_offset, y_offset)
    current_x, current_y = @cursor_position
    @grid[current_y][current_x] = "_"
    new_x = current_x + x_offset
    new_y = current_y + y_offset
    @grid[new_y][new_x] = "$"
    @cursor_position = [new_x, new_y]
  end

  def grid_string
    string = ""
    @grid.each do |row|
      row.each { |char| string << "#{char} " }
      string << "\n"
    end
    string
  end

end

demo = Demo.new

Dispel::Screen.open do |screen|
  screen.draw demo.grid_string

  Dispel::Keyboard.output do |key|
    break if key == :"Ctrl+c"
    case key
    when :up then demo.move_cursor(0,-1)
    when :down then demo.move_cursor(0,1)
    when :right then demo.move_cursor(1,0)
    when :left then demo.move_cursor(-1,0)
    end
    screen.draw demo.grid_string
  end
end
