require_relative 'node.rb'
require 'pry'

class Tree
  def initialize(data_set)
    @root = nil
    @data_set = data_set
    build_tree
  end

  def build_tree
    first = @data_set[0]
    last = @data_set[-1]

    if first > last 
      return nil
    end

    mid = @data_set[(first + last) / 2]
    left_half = @data_set[0..(mid - 1)]
    right_half = @data_set[(mid + 1)..-1]
    
    # left_half outputs array with mid included???

    binding.irb
    @root = Node.new(mid, left_half, right_half)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end