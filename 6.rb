input = File.read('6.txt').split("\n\n")

count1 = 0

input.each do |group|
  answers = group.split("\n").join('').split(//).uniq
  count1 += answers.count
end

count2 = 0
input.each do |group|
  forms = group.split("\n")
  forms[0].split(//).each do |answer|
    count2 += 1 if forms.all? { |f| f.include? answer }
  end
end

puts count1
puts count2

