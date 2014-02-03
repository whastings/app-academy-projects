class Point

  attr_reader :x, :y
  attr_accessor :parent, :visited

  def initialize(x, y, empty)
    @x, @y, @empty = x, y, empty
  end

  def empty?
    @empty
  end

  def above(other_point)
    x == other_point.x && (y - 1) == other_point.y
  end

  def below(other_point)
    x == other_point.x && (y + 1) == other_point.y
  end

  def vertical_to(other_point)
    above(other_point) || below(other_point)
  end

  def to_right(other_point)
    y == other_point.y && (x - 1) == other_point.x
  end

  def to_left(other_point)
    y == other_point.y && (x + 1) == other_point.x
  end

  def horizontal_to(other_point)
    to_right(other_point) || to_left(other_point)
  end

  def orthagonal_to(other_point)
    vertical_to(other_point) || horizontal_to(other_point)
  end

  def diagonal_to(other_point)
    diagonals = [
      (x + 1 == other_point.x && y - 1 == other_point.y),
      (x - 1 == other_point.x && y - 1 == other_point.y),
      (x - 1 == other_point.x && y + 1 == other_point.y),
      (x + 1 == other_point.x && y + 1 == other_point.y)
    ]
    diagonals.any?
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  def inspect
    to_s
  end

end
