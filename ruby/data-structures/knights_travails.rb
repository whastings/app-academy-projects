# Pair programming partner: Allen Kim

require './tree_node'

class KnightPathFinder
  attr_accessor :node_tree

  def self.new_move_positions(pos)
    movements = [
      [1, 2], [2, 1], [2, -1], [-2, 1],
      [-2, -1], [-1, -2], [-1, 2], [1, -2]
    ]
    movements.map! { |x, y| [pos.first + x, pos.last + y] }
    movements.select { |x, y| (0..7).include?(x) && (0..7).include?(y) }
  end

  def initialize(starting)
    @starting = starting
    build_move_tree(starting)
  end

  def build_move_tree(starting)
    @node_tree = TreeNode.new(starting)
    visited = [starting]
    queue = [@node_tree]
    until queue.empty?
      current_node = queue.shift
      possible_moves = self.class.new_move_positions(current_node.value)
      possible_moves.each do |move|
        next if visited.include? move
        queue << TreeNode.new(move, current_node)
        visited << move
      end
    end
  end

  def find_path(ending)
    target_node = self.node_tree.bfs(ending)
    ([target_node] + target_node.path).reverse!
  end

end
