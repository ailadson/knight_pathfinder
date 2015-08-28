require "./poly_tree.rb"
require 'byebug'

class KnightPathFinder
  def self.valid_moves(pos)
    valid_moves = []
    transformations = [[1, 2], [1, -2], [2, 1], [2, -1],
                      [-1, 2], [-1, -2], [-2, 1], [-2, -1]]

    transformations.each do |trans_pos|
      x = trans_pos[0] + pos[0]
      y = trans_pos[1] + pos[1]
      unless (x < 0) || (y < 0) || (x > 7) || (y > 7)
        valid_moves << [x, y]
      end
    end

    valid_moves
  end

  def initialize(starting_position)
    @start_position = starting_position
    @visited_positions = []
    @tree_root = build_move_tree
  end

  def build_move_tree
    start_node = PolyTreeNode.new(@start_position)
    queue = [start_node]

    until queue.empty?
      current_node = queue.shift
      children = new_move_positions(current_node.value)
      children.each do |child|
        child_node = PolyTreeNode.new(child)
        child_node.parent = current_node
        queue << child_node
      end
    end

    start_node
  end

  def new_move_positions(pos)
    new_pos = KnightPathFinder.valid_moves(pos).select{ |pos| !@visited_positions.include?(pos) }
    @visited_positions += new_pos
    new_pos
  end

  def find_path(end_pos)
    @tree_root.trace_path_back(@tree_root.dfs(end_pos))
  end
end


if __FILE__ == $PROGRAM_NAME
  start_pos = ARGV[0].split(",").map{|arg| arg.to_i }
  end_pos = ARGV[1].split(",").map{|arg| arg.to_i }
  
  k = KnightPathFinder.new(start_pos)
  p k.find_path(end_pos)
end