class Maze

  attr_accessor :grid, :starting_point, :ending_point

  def initialize(grid, starting_point, ending_point)
    @grid, @starting_point, @ending_point = grid, starting_point, ending_point
  end

  def at(x, y)
    @grid[y] && @grid[y][x]
  end

  # Finds all points adjacent to a given point.
  def adjacent(point)
    above, below = point.y + 1, point.y - 1
    right, left = point.x + 1, point.x - 1
    locations = [
      [left, above], [point.x, above], [right, above],
      [left, point.y],                 [right, point.y],
      [left, below], [point.x, below], [right, below]
    ]
    points = locations.map { |(x, y)| at(x, y) }
    points.compact
  end

  def empty_adjacent(point)
    adjacent(point).select { |adjacent_point| adjacent_point.empty? }
  end

  def mark_visited
    visited_point = @ending_point
    while visited_point.parent
      visited_point.visited = true
      visited_point = visited_point.parent
    end
  end

end
