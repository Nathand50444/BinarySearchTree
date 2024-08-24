class Tree
  def initialize
    @root = nil
  end

  def build_tree(*input)
    data_set = [input]
    first = data_set[0]
    last = data_set[-1]

    if first > last 
      return nil
    mid = array[(first + last) / 2]
    @root = Node.new(mid)

    
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end