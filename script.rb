class Tree
  def initialize(array)
    @array = array
    @root = build_tree(array)
  end

  # builds the initial tree with recursion
  def build_tree(array)
    array = merge_sort(array)
    array = delete_dupes(array)

    start_tree = array[0]
    end_tree = array.length

    if start_tree > end_tree
      return nil
    end

    mid_tree = (start_tree + (end_tree -start_tree)) / 2

    root = array[mid_tree]
    left_child = build_tree(array[start_tree..mid_tree-1])
    right_child = build_tree(array[mid_tree+1..end_tree])

    node = Node.new(root, left_child, right_child)
  end

  # accepts a value to insert in the tree
  def insert(value)
  end
  
  # accepts a value to delete in the tree
  def delete(value)
  end

  # accepts a value, returns node with that value
  def find(value)
  end

  # accepts a block
  # traverse the tree in breadth first level order and yield each node to the block
  def level_order(&block)
  end

  # traverse tree in depth first inorder order and yields each node to the block
  def inorder(&block)
  end

  # traverse tree in depth first preorder order and yields each node to the block
  def preorder(&block)
  end

  # traverse tree in depth first postorder order and yields each node to the block
  def postorder(&block)
  end

  # accepts a node and returns its depth
  # depth is defined as the number of edges in path from a given node to the tree's root node
  def height(node)
  end

  # checks if tree is balanced
  # a balanced tree is defined as one where the difference between heights of the left subtree and right subtree of every node is not more than 1
  def balanced?
  end

  # rebalances an unbalanced tree
  # traverses the tree to create an array, then passes array to build_tree
  def rebalance
  end

  def merge_sort(arr)
    if arr.length < 2
      return arr
    else
      full_arr = []
      left_arr = merge_sort(arr[0..arr.length/2-1])
      right_arr = merge_sort(arr[arr.length/2..])
      i_l = 0
      i_r = 0
      while i_l < left_arr.length && i_r < right_arr.length
        if left_arr[i_l] < right_arr[i_r]
          full_arr.push(left_arr[i_l])
          i_l += 1
        else
          full_arr.push(right_arr[i_r])
          i_r += 1
        end
      end
      if i_l == left_arr.length
        full_arr.push(right_arr[i_r..])
      else
        full_arr.push(left_arr[i_l..])
      end
      full_arr = full_arr.flatten
    end
  end

  def delete_dupes(arr)
    p "array = #{arr}"
    last_value = nil
    i = 0
    while i < arr.length
      value = arr[i]
      p "value = #{value}"
      p "last_value = #{last_value}"
      if last_value == value
        arr.delete_at(i)
        arr
        next
      end
      last_value = value
      i += 1
    end
    arr
  end
end

class Node
  include Comparable
  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end


