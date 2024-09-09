require_relative 'node.rb'

class Tree
  
  def initialize
    @root = nil
  end

  def build_tree(data_set)
    # Ensure that the data set is sorted before calling build_tree to create the BST.
    sorted_data_set = data_set.sort.uniq
    @root = build_tree_recursive(sorted_data_set)
  end

  # build_tree takes a given data_set and produces a binary tree of the given data
  def build_tree_recursive(data_set)
    return nil if data_set.empty?

    # The method recursively splits the data set into halves
    mid_index = data_set.length / 2
    mid = data_set[mid_index]
    left_half = data_set[0...mid_index]
    right_half = data_set[mid_index + 1..-1]

    # Recursively build the left and right subtrees.
    left_node = build_tree(left_half)
    right_node = build_tree(right_half)

    # Create a new node with the middle element as the data and attach the left and right subtrees.
    node = Node.new(mid, left_node, right_node)

    # Return the newly created node
    node
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
      # The current node's data is compared to the provided 'data'
      # The tree is traversed based on 'data < current.data'
    end

    new_node = Node.new(data)
    # We create a new node of the given data and assign the new node accordingly
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
    # Here we have to accomodate multiple cases as follows:
    # We traverse the branches of the tree based on whether data is less than or greater than the current node.
    # If the data is less than the current node, traverse the left branch
    # If the data is greater than the current node, traverse the right branch
    # If the current node is nil, return nil
    # If the current node has no children, delete the current node
    # If the current node has one child, replace the current node with the child
    # If the current node has two children, replace the current node with the in-order successor
    current = find(data)
    if current.nil?
      return nil
    end

    if current.left.nil? && current.right.nil?
      if current.parent.nil?
        @root = nil
      else
        if current.parent.left == current
          current.parent.left = nil
        else
          current.parent.right = nil
        end
      end
    elsif current.left && current.right.nil?
      if current.parent.nil?
        @root = current.left
      else
        if current.parent.left == current
          current.parent.left = current.left
        else
          current.parent.right = current.left
        end
      end
    elsif current.right && current.left.nil?
      if current.parent.nil?
        @root = current.right
      else
        if current.parent.left == current
          current.parent.left = current.right
        else
          current.parent.right = current.right
        end
      end
    else
      min_node = current.right
      while min_node.left
        min_node = min_node.left
      end
      current.data = min_node.data
      if min_node.parent.left == min_node
        min_node.parent.left = nil
      else
        min_node.parent.right = nil
      end
    end
  end

  def find(data)
    # Traverse the branches of the tree based on whether data is less than or greater than the current node.
    # If the data is less than the current node, traverse the left branch
    # If the data is greater than the current node, traverse the right branch
    # If the current node is nil, return nil
    # If the current node is the data, return the current node
    current = @root

    while current
      if current.data == data
        return current
      else
        current = data < current.data ? current.left : current.right
        # We traverse the tree until 'current.data == data' at which point it is 'found'
      end
    end
    nil
  end

  def level_order
    # Node elements should be compiled into an array in "level order"
    # For examples, the first level should be the root node.
    # The second and third levels should be the left and right children of the root node, etc.
    nodes = [@root]
    return [] if nodes.first.nil?
    result = []

    until nodes.empty?
      current = nodes.shift
      result << current.data
      nodes << current.left if current.left
      nodes << current.right if current.right
    end
    p result
  end

  def inorder(node = @root)
    # The Tree is traversed in this order: left subtree, root then right subtree.
    # Starting from the root, recursively traverse the left subtree
    # Yield each node to the block or add its value to an array.
    # Traverse the right subtree and add the values to the array.
    inorder_list = []

    inorder_traversal = lambda do |node|
      return if node.nil? 
      inorder_traversal.call(node.left)
      inorder_list << node.data
      inorder_traversal.call(node.right)
    end

    inorder_traversal.call(node)
    p inorder_list
  end

  def preorder(node = @root)
    preorder_list = []

    preorder_traversal = lambda do |node|
      return if node.nil?
      preorder_list << node.data
      preorder_traversal.call(node.left)
      preorder_traversal.call(node.right)
    end

    preorder_traversal.call(node)
    p preorder_list
  end

  def postorder(node = @root)
    postorder_list = []

    postorder_traversal = lambda do |node|
      return if node.nil?
      postorder_traversal.call(node.left)
      postorder_traversal.call(node.right)
      postorder_list << node.data
    end

    postorder_traversal.call(node)
    p postorder_list
  end

  def height(data)
    # Works similarly to find(data) but return the HEIGHT of the data
    # i.e. returns the longest path and number of connections/lines between the root and THE LEAF NODE of the data
    # The "leaf node" is a node that has no left or right trees
    node = find(data)
    return -1 if node.nil?
    height_node(node)
  end

  def height_node(node)
    return 0 if node.nil?
    [height_node(node.left), height_node(node.right)].max + 1
  end

  def depth(data)
    # Works similarly to find(data) but return the HEIGHT of the data
    # i.e. returns the longest path and number of connections/lines between the root and THE LEAF NODE of the data
    # The "leaf node" is a node that has no left or right trees
    current = @root
    depth_tally = 0

    while current
      if current.data == data
        return depth_tally
      else
        current = data < current.data ? current.left : current.right
        depth_tally += 1
      end
    end
    -1
  end

  def balanced?(node = @root)
    # Uses height_node to caclulate the height of each branch and compares them.
    return true if node.nil?
    left_height = height_node(node.left)
    right_height = height_node(node.right)

    return false if (left_height - right_height).abs > 1
    balanced?(node.left) && balanced?(node.right)
  end

  def check_balance
    if balanced?
      puts "Balanced!"
    else
      puts "Imbalanced!"
    end
  end

  def rebalance
    # Method should rebalance the tree
    # Tree is traversed INORDER and creates a new array for the method build_tree(data_set)
    # INORDER traversal will mean we get a sorted array of nodes.
    # Pass the sorted array into the build_tree(data_set) method
    data = inorder
    @root = build_tree(data)
  end

  private

  def pretty_print_node(node, prefix, is_left)
    return if node.nil?

    pretty_print_node(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print_node(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
