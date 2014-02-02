# Pair programming partner: Allen Kim

require './tree_node'

node1 = TreeNode.new("a")
node2 = TreeNode.new("b", node1)
node3 = TreeNode.new("c", node1)
node4 = TreeNode.new("d", node2)
node5 = TreeNode.new("e", node2)
node6 = TreeNode.new("f", node3)
node7 = TreeNode.new("g", node3)

p node1.dfs('g').ancestors
p node1.last_search_path
p node1.bfs('g').ancestors
p node1.last_search_path
