input = File.read('7.txt').split("\n")

puts "#{input.length} lines of input"

g = {}

MY_BAG_COLOR = "shiny gold"

input.each do |rule|
  rule = rule.split(" bags contain ")
  c_subject = rule[0]
  matches = rule[1].scan(/(\d+)(([a-z]|\s)+)(bags|bag)/)
  matches.each do |m|
    num = m[0].strip
    color = m[1].strip
    g[c_subject] = [] if g[c_subject].nil?
    g[c_subject] << { color: color, n: num }
  end
end

def find_bags_containing(g, target_c)
  containers = []
  g.each do |k, v|
    if v.any? { |s| s[:color] == target_c }
      containers << k
    end
  end

  if containers.size > 0
    containers.each do |c|
      containers += find_bags_containing(g, c)
    end
  end

  containers.uniq
end

n_bags = 0
bag_containers = find_bags_containing(g, MY_BAG_COLOR)
n_bags += bag_containers.count

puts n_bags

def count_bags_within(g, target_c)
  inner_bags = 0
  return 0 if g[target_c].nil?
  g[target_c].each do |requirement|
    c = requirement[:color]
    n = requirement[:n].to_i
    inner_bags += n
    inner_bags += n * count_bags_within(g, c)
  end

  inner_bags
end

puts count_bags_within(g, MY_BAG_COLOR)
