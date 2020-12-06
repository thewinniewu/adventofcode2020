input = File.read('2.txt').split("\n")

valid_count1 = 0
valid_count2 = 0

puts "#{input.length} lines of input"

input.each do |pw|
  components = pw.split(" ")
  limits = components[0].split('-')
  letter = components[1][0]
  word = components[2]

  count = word.scan(/#{letter}/).count  
  if count >= limits[0].to_i && count <= limits[1].to_i
    valid_count1 += 1
  end

  index1 = limits[0].to_i - 1
  index2 = limits[1].to_i - 1
  
  if word[index1] == letter && word[index2] != letter || word[index2] == letter && word[index1] != letter
    valid_count2 += 1
  end
end
puts valid_count1
puts valid_count2
