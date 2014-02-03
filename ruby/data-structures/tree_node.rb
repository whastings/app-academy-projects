# Pair programming partner: Allen Kim

class TreeNode

  attr_accessor :parent, :value, :children, :last_search_path

  def initialize(value, parent = nil)
    @value = value
    parent.add_child(self) unless parent.nil?
    @children = []
  end

  def remove_child(node)
    node.parent = nil
    self.children.delete(node)
  end

  def add_child(node)
    node.parent.remove_child(node) unless node.parent.nil?
    self.children << node
    node.parent = self
  end

  def dfs(value)
    @last_search_path = [self]
    return self if self.value == value
    self.children.each do |child|
      match = child.dfs(value)
      @last_search_path.concat(child.last_search_path)
      return match unless match.nil?
    end
    nil
  end

  def bfs(value)
    @last_search_path = []
    queue = [self]
    until queue.empty?
      node = queue.shift
      @last_search_path << node
      return node if node.value == value
      queue.concat node.children
    end
    nil
  end

  def ancestors
    ancestors = []
    parent = self.parent
    until parent.nil?
      ancestors << parent
      parent = parent.parent
    end
    ancestors
  end

  alias_method :path, :ancestors

  def descendants
    self.dfs(nil)
    self.last_search_path
  end

  def to_s
    self.value
  end

  def inspect
    self.to_s
  end

end
