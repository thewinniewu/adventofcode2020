input = File.read('3.txt').split("\n")

def trees_on_traverse(x, y, input)
  num_trees = 0
  pos = 0
  input.each_cons(y+1).to_a.each_with_index do |lines, i|
    next if i  % y != 0
    line = lines.first
    next_line = lines.last
    new_pos = (pos + x) % line.length
    num_trees += 1 if next_line[new_pos] == '#'
    pos = new_pos
  end
  num_trees
end

puts trees_on_traverse(3, 1, input)
puts "---"
puts trees_on_traverse(1,1,input) * trees_on_traverse(3,1,input) * trees_on_traverse(5,1,input) * trees_on_traverse(7,1,input) * trees_on_traverse(1,2,input)
