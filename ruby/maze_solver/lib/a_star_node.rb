class AStarNode
  attr_reader :base_node

  def initialize(base_node, end_node)
    @base_node = base_node
    @end_node = end_node
  end

  def method_missing(method_name, *args, &block)
    @base_node.send(method_name, *args, &block)
  end

  def g_score(recalculate = false)
    if @g_score.nil? || recalculate
      @g_score = calculate_g
    end
    @g_score
  end

  def h_score(recalculate = false)
    if @h_score.nil? || recalculate
      @h_score = calculate_h(@end_node)
    end
    @h_score
  end

  def f_score(recalculate = false)
    if @f_score.nil? || recalculate
      @f_score = g_score(recalculate) + h_score(recalculate)
    end
    @f_score
  end

  def reconsider_score(previous_node)
    current_g = g_score
    current_parent = parent
    self.parent = previous_node
    new_g = g_score(true)
    if new_g >= current_g
      self.parent = current_parent
      g_score(true)
    end
  end

  def <=>(other_node)
    return -1 if f_score < other_node.f_score
    return 1 if f_score > other_node.f_score
    0
  end

  def to_s
    @base_node.to_s
  end

  def inspect
    @base_node.inspect
  end

  def ==(other_node)
    @base_node.x == other_node.base_node.x &&
      @base_node.y == other_node.base_node.y
  end

  private

  def calculate_g
    g = 0
    return g unless parent
    g += parent.g_score
    if parent.orthagonal_to(self)
      g += 10
    elsif parent.diagonal_to(self)
      g += 14
    end
    g
  end

  def calculate_h(end_node)
    moves = 0
    moves += (self.x - end_node.x).abs
    moves += (self.y - end_node.y).abs
    moves * 10
  end

end
