Node = Struct.new(:score)

node1 = Node.new(4)
node2 = Node.new(6)

nodes = [node1, node2]
# 
# v = nodes.inject(0) {|s, n| s += n.score}
# 
# puts(v)
n = nodes.detect { |n1| n1.score == 8}
puts(n == nil)