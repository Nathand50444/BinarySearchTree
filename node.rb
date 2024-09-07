class Node
  attr_accessor :data, :left, :right, :parent

  def initialize(data, left = nil, right = nil, parent = nil)
    @data = data
    @left = left
    @right = right
    @parent = parent
  end
end