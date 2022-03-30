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
  def insert(value, root = @root)
    if value == root.data
      puts "That value already exists in the tree"
    elsif value < root.data
      if root.left_child.nil? == false
        insert(value, root.left_child)
      else
        root.left_child = Node.new(value)
      end
    else
      if root.right_child.nil? == false
        insert(value, root.right_child)
      else
        root.right_child = Node.new(value)
      end
    end
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
  def level_order(proc, root = @root)
    return if root.nil?

    queue = []
    queue.push(root)
    while queue.empty? == false
      data = queue[0]
      proc.call(data)
      if data.left_child.nil? == false
        queue.push(data.left_child)
      end
      if data.right_child.nil? == false
        queue.push(data.right_child)
      end
      queue.shift
      queue
    end
  end

  # traverse tree in depth first inorder order and yields each node to the block
  def inorder(proc, root = @root)
    return if root.nil?

    inorder(proc, root.left_child)
    proc.call(root)
    inorder(proc, root.right_child)
  end

  # traverse tree in depth first preorder order and yields each node to the block
  def preorder(proc, root = @root)
    return if root.nil?

    proc.call(root)
    preorder(proc, root.left_child)
    preorder(proc, root.right_child)
  end

  # traverse tree in depth first postorder order and yields each node to the block
  def postorder(proc, root = @root)
    return if root.nil?

    postorder(proc, root.left_child)
    postorder(proc, root.right_child)
    proc.call(root)
  end

  # accepts a node and returns its height
  # height is defined as the number of edges in longest path from a given node to a leaf node.
  def height(node)
    return -1 if node.nil? == true

    l_height = height(node.left_child)
    r_height = height(node.right_child)

    [l_height, r_height].max + 1
  end

  # accepts a node and returns its depth
  # depth is defined as the number of edges in path from a given node to the tree's root node
  def depth(node)
    depth = 0
    root = @root
    while node != root
      if node.data < root.data
        root = root.left_child
        depth += 1
      else
        root = root.right_child
        depth += 1
      end
    end
    depth
  end

  # checks if tree is balanced
  # a balanced tree is defined as one where the difference between heights of the
  # left subtree and right subtree of every node is not more than 1
  def balanced?
    root = @root
    l_height = height(root.left_child)
    r_height = height(root.right_child)

    if abs(l_height - r_height) > 1
      false
    else
      true
    end
  end

  # rebalances an unbalanced tree
  # traverses the tree to create an array, then passes array to build_tree
  def rebalance
    array = []
    proc = Proc.new { |value| array.push(value) }
    level_order(proc, @root)
    @root = build_tree(array.sort)
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

proc = Proc.new { |value| puts value.data }

# tree.insert(2)
# tree.level_order(proc)
# tree.preorder(proc)
# tree.postorder(proc)
# tree.rebalance

node = tree.find(1)
p tree.height(node)

node2 = tree.find(3)
p tree.depth(node2)
