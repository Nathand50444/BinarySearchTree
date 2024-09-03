require_relative 'binary_tree.rb'

# 1. Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) }) YES
# 2. Confirm that the tree is balanced by calling #balanced? YES
# 3. Print out all elements in level, pre, post, and in order
# 4. Unbalance the tree by adding several numbers > 100
# 5. Confirm that the tree is unbalanced by calling #balanced?
# 6. Balance the tree by calling #rebalance
# 7. Confirm that the tree is balanced by calling #balanced?
# 8. Print out all elements in level, pre, post, and in order.

test = Tree.new
test.build_tree(Array.new(15) { rand(1..100) })
test.pretty_print
test.check_balance
test.level_order
test.preorder
test.postorder
test.inorder
test.insert(120) # Issue with new_node.parent = parent

# test.insert(193)
# test.insert(154)
# test.insert(132)
# test.check_balance
# test.rebalance