class Tree
  def initialize(data_set, parent_node = nil)
    @root = nil
    @data_set = data_set
    @parent_node = parent_node

    if @parent_node.nil?
      start_tree
    else
      build_tree
    end
  end

  end

  def start_tree
    @data_set = [input]
    first = @data_set[0]
    last = @data_set[-1]

    if first > last 
      return nil
    end

    mid = @data_set[(first + last) / 2]
    left_half = @data_set[0..(mid - 1)]
    right_half = @data_set[(mid + 1)..-1]

    @root = Node.new(mid, left_half, right_half)
  end

  def build_tree
    @data_set = [input]
    first = @data_set[0]
    last = @data_set[-1]

    if first > last 
      return nil
    end

    mid = @data_set[(first + last) / 2]
    left_half = @data_set[0..(mid - 1)]
    right_half = @data_set[(mid + 1)..-1]

    @root = Node.new(mid, left_half, right_half)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end