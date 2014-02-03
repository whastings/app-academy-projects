class TextMazeParser

  EMPTY_CHAR = " "
  FILLED_CHAR = "*"
  STARTING_CHAR = "S"
  ENDING_CHAR = "E"
  VISITED_CHAR = "X"

  def initialize(maze_string)
    @maze_string = maze_string
  end

  def parse
    grid, y = [], 0
    starting_point, ending_point = nil, nil
    @maze_string.split("\n").each do |line|
      row, x = [], 0
      line.split("").each do |char|
        point = Point.new(x, y, char != FILLED_CHAR)
        row << point
        starting_point = point if char == STARTING_CHAR
        ending_point = point if char == ENDING_CHAR
        x += 1
      end
      grid << row
      y += 1
    end
    [grid, starting_point, ending_point]
  end

  def print_maze(maze)
    maze.mark_visited
    grid = maze.grid
    grid.each do |row|
      row.each do |point|
        if point == maze.starting_point
          print STARTING_CHAR
        elsif point == maze.ending_point
          print ENDING_CHAR
        elsif !point.empty?
          print FILLED_CHAR
        elsif point.visited
          print VISITED_CHAR
        else
          print EMPTY_CHAR
        end
      end
      puts
    end
  end

end
