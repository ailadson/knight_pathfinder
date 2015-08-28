class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def inspect
    "Node: #{@value}"
  end

  def parent=(val)
    unless val.nil? || val.children.include?(self)
        val.children << self
        unless @parent.nil?
          @parent.children.delete(self)
        end
    end

    @parent = val
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise Exception.new("Error") unless @children.include?(child)
      child.parent = nil
      @children.delete(child)
  end

  def dfs(target_value)
    return self if target_value == @value
    @children.each do |child_node|
      found_node = child_node.dfs(target_value)

        unless found_node.nil?
        # if found_node.is_a?(Array) && found_node.empty?
        #   next
            return found_node

        end

    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      parent = queue.shift
      if parent.value == target_value
        return parent
      else
        queue.concat(parent.children)
      end
    end
  end

  def trace_path_back(node)
    return [] if node.nil?
    path = [node.value]
    path = trace_path_back(node.parent) + path

  end
end
