class Node
    attr_accessor :right_child, :left_child, :parent_node, :value
    def initialize(value, parent_node)
        @value = value
        @parent_node = parent_node
    end
end

# Loop through array
# Check current item value against root node value
# if value is greater set current node to right child
# Else set value of current node to left child
# While loop until chosen side node is nil
    # # If current node = nil, set current child to value of the current item

def build_tree(list)
    root = Node.new(list[0], nil)
    list[1...list.length].each do |item|
        current_node = root
        while !item.nil?
            if item > current_node.value
                if current_node.right_child.nil?
                    current_node.right_child = Node.new(item, current_node)
                    item = nil
                else
                    current_node = current_node.right_child
                end
            elsif item < current_node.value
                if current_node.left_child.nil?
                    current_node.left_child = Node.new(item, current_node)
                    item = nil
                else
                    current_node = current_node.left_child
                end
            else
                item = nil
            end
        end
    end
    root
end

def breadth_first_search(value, tree_root)
    queue = [tree_root]

    until queue.empty?
        element = queue.shift
        # Returns a matched node value to the search value
        return element if element.value == value
        # Adds each left and right child to the queue if not nil
        queue << element.left_child if !element.left_child.nil?
        queue << element.right_child if !element.right_child.nil?
    end
    return nil
end



def depth_first_search(value, tree_root)
    stack = [tree_root]
    visited = []

    until stack.empty?
        # Chooses current node from end of stack
        element = stack[-1]

        return element if element.value == value
        # If there is a left_child node that hasn't been looked at, add it to stack and keep looking further down
        if !element.left_child.nil? && !visited.include?(element.left_child)
            stack << element.left_child
            visited << element.left_child
        # If there isn't a left node check the right side
        elsif !element.right_child.nil? && !visited.include?(element.right_child)
            stack << element.right_child
            visited << element.right_child
        # if there is no left or right node that can be checked or if both have been checked, pop off the last value from the stack to move up
        else
            stack.pop
        end
    end
    return nil
end

# Returns node
root = build_tree([1,8,4,18,8,3,-4, 72])

# Gives back node with the search value
puts depth_first_search(4, root)
puts breadth_first_search(18, root)

