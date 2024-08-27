require_relative 'node.rb'

class Tree
  def initialize
    @root = nil
  end

  def build_tree(data_set)
    return nil if data_set.empty?

    mid_index = data_set.length / 2
    mid = data_set[mid_index]
    left_half = data_set[0...mid_index]
    right_half = data_set[mid_index + 1..-1]
    
    left_node = build_tree(left_half)
    right_node = build_tree(right_half)
    
    @root = Node.new(mid, left_node, right_node)
  end

  def pretty_print
    pretty_print_node(@root, '', true)
  end

  private

  def pretty_print_node(node, prefix, is_left)
    return if node.nil?

    pretty_print_node(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print_node(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# Example
test = Tree.new
test.build_tree([1, 2, 3, 4, 5, 6, 7, 8, 9])
test.pretty_print
