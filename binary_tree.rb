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

  def insert(data)
    # Traverse the branches of the tree based on whether data is less than or greater than the current node.
    # If the data is less than the current node, traverse the left branch
    # If the data is greater than the current node, traverse the right branch
    # If the current node is nil, create a new node with the data and return the new node.
    current = @root
    parent = nil
    
    while current
      parent = current
      current = data < current.data ? current.left : current.right
    end
    
    new_node = Node.new(data)
    if parent.nil?
      @root = new_node
    else
      new_node.parent = parent
      if data < parent.data
        parent.left = new_node
      else
        parent.right = new_node
      end
    end
  end

  def delete(data)
    # Traverse the branches of the tree based on whether data is less than or greater than the current node.
    # If the data is less than the current node, traverse the left branch
    # If the data is greater than the current node, traverse the right branch
    # If the current node is nil, return nil
    # If the current node has no children, delete the current node
    # If the current node has one child, replace the current node with the child
    # If the current node has two children, replace the current node with the in-order successor
  end

  def find(data)
    # Traverse the branches of the tree based on whether data is less than or greater than the current node.
    # If the data is less than the current node, traverse the left branch
    # If the data is greater than the current node, traverse the right branch
    # If the current node is nil, return nil
    # If the current node is the data, return the current node 
    # (what information does this give us? Can we return the Node ID?)
    current = @root
    
    while current
      if current.data == data
        return current
      else
        current = data < current.data ? current.left : current.right
      end
    end
    nil
  end

  def level_order
    # Node elements should be compiled into an array in "level order"
    # For examples, the first level should be the root node.
    # The second and third levels should be the left and right children of the root node, etc.
  end

  private

  def pretty_print_node(node, prefix, is_left)
    return if node.nil?

    pretty_print_node(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print_node(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
