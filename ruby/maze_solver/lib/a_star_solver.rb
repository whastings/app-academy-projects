require "a_star_node"

class AStarSolver

  def initialize(maze)
    @maze = maze
    @maze.starting_point = AStarNode.new(@maze.starting_point, @maze.ending_point)
    @maze.ending_point = AStarNode.new(@maze.ending_point, @maze.ending_point)
    @maze.grid.map! do |row|
      row.map { |point| AStarNode.new(point, @maze.ending_point) }
    end
    @current_node = @maze.starting_point
    @nodes_to_explore = [@current_node]
    @nodes_explored = []
  end

  def solve
    while @current_node != @maze.ending_point
      move
    end
  end

  private

  def move
    possible_moves = @maze.empty_adjacent(@current_node)
    possible_moves.reject! { |move| @nodes_explored.include?(move) }
    possible_moves.each do |move|
      if @nodes_to_explore.include?(move)
        move.reconsider_score(@current_node)
        next
      end
      move.parent = @current_node
      @nodes_to_explore << move
    end
    @nodes_to_explore.delete(@current_node)
    @nodes_explored << @current_node
    @current_node = @nodes_to_explore.min
  end

end
