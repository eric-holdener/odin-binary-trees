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
  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left_child = delete(value, node.left_child)
    elsif value > node.data
      node.right_child = delete(value, node.right_child)
    else
      return node.right_child if node.left_child.nil?
      return node.left_child if node.right_child.nil?

      leftmost_node = leftmost_leaf(node.right_child)
      node.data = leftmost_node.data
      node.right_child = delete(leftmost_node.data, node.right_child)
    end
  node
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

    difference = l_height - r_height

    if difference.abs > 1
      false
    else
      true
    end
  end

  # rebalances an unbalanced tree
  # traverses the tree to create an array, then passes array to build_tree
  def rebalance
    array = []
    proc = Proc.new { |value| array.push(value.data) }
    level_order(proc, @root)
    @root = build_tree(array.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def leftmost_lead(node)
    node = node.left_child until node.left_child.nil?

    node
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



def driver
  # create a binary search tree from an array of random numbers
  arr = (Array.new(15) { rand(1..100) })
  tree = Tree.new(arr)

  # confirm tree is balanced
  p "Balanced = #{tree.balanced?}"

  # print out all elements in level, pre, post, and in order
  proc = Proc.new { |value| puts value.data }
  puts 'Level order'
  tree.level_order(proc)
  puts 'Preorder'
  tree.preorder(proc)
  puts 'Postorder'
  tree.postorder(proc)
  puts 'Inorder'
  tree.inorder(proc)

  tree.pretty_print

  # unbalance the tree by adding several numbers > 100
  tree.insert(115)
  tree.insert(200)
  tree.insert(150)
  tree.insert(250)

  tree.pretty_print

  # confirm the tree is unbalanced by calling balanced?
  p "Balanced = #{tree.balanced?}"

  # balance the tree by calling rebalance
  tree.rebalance

  # confirm tree is balanced
  p "Balanced = #{tree.balanced?}"

  # print out all elements in level, pre, post, and in order
  puts 'Level order'
  tree.level_order(proc)
  puts 'Preorder'
  tree.preorder(proc)
  puts 'Postorder'
  tree.postorder(proc)
  puts 'Inorder'
  tree.inorder(proc)

  tree.pretty_print
end

driver