class Tree
  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  # builds the initial tree with recursion
  def build_tree(array)
    return nil if array.empty?

    middle = (array.size - 1) / 2
    root_node = Node.new(array[middle])

    root_node.left_child = build_tree(array[0...middle])
    root_node.right_child = build_tree(array[(middle + 1)..-1])

    root_node
  end

  # accepts a value to insert in the tree
  def insert(value)
  end

  # accepts a value to delete in the tree
  def delete(value)
  end

  # accepts a value, returns node with that value
  def find(value)
    root = @root
    while value != root.data
      if value > root.data
        root = root.right_child
      else
        root = root.left_child
      end
    end
    root
  end

  # accepts a block
  # traverse the tree in breadth first level order and yield each node to the block
  def level_order
  end

  # traverse tree in depth first inorder order and yields each node to the block
  def inorder(proc, root = @root)
    return if root.nil?

    inorder(proc, root.left_child)
    proc.call(root.data)
    inorder(proc, root.right_child)
  end

  # traverse tree in depth first preorder order and yields each node to the block
  def preorder(proc, root = @root)
    return if root.nil?

    proc.call(root.data)
    preorder(proc, root.left_child)
    preorder(proc, root.right_child)
  end

  # traverse tree in depth first postorder order and yields each node to the block
  def postorder(proc, root = @root)
    return if root.nil?

    postorder(proc, root.left_child)
    postorder(proc, root.right_child)
    proc.call(root.data)
  end

  # accepts a node and returns its depth
  # depth is defined as the number of edges in path from a given node to the tree's root node
  def height(node)
  end

  # checks if tree is balanced
  # a balanced tree is defined as one where the difference between heights of the
  # left subtree and right subtree of every node is not more than 1
  def balanced?
  end

  # rebalances an unbalanced tree
  # traverses the tree to create an array, then passes array to build_tree
  def rebalance
  end
end

class Node
  attr_accessor :left_child, :right_child, :data

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end
end

arr = [1, 3, 5, 6, 1, 7]
tree = Tree.new(arr)
p tree.find(6)

proc = Proc.new { |value| puts value }

tree.inorder(proc)
tree.preorder(proc)
tree.postorder(proc)
