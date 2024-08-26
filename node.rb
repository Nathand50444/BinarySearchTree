class Node
  def initialize(value, left, right)
    @node = value
    @left = Tree.new(left)
    @right = Tree.new(right)
  end
end