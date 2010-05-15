class Tree
  attr_accessor :children, :node_name

  def initialize(tree)
    if tree.class == String
      @node_name = tree
      @children = []
    else
      @node_name = tree.keys.first

      @children = tree[@node_name].inject([]) do |children, child|
        children << Tree.new(child)
      end
    end
  end

  def visit_all(&block)
    visit &block
    children.each { |c| c.visit_all &block }
  end

  def visit(&block)
    block.call self
  end
end

ruby_tree = Tree.new 'grandpa' => [{'dad' => ['child 1', 'child 2']},{'uncle' => ['child 3', 'child 4']}]

puts "Visiting a node"
ruby_tree.visit {|node| puts node.node_name }
puts

puts "visiting entire tree"
ruby_tree.visit_all {|node| puts node.node_name }
