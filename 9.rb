input = File.read('9.txt').split("\n")

puts "#{input.length} lines of input"

preamble = []
invalid_key = nil

def pairs_exist(preamble, num)
  exists = false
  preamble.each_with_index do |p, i|
    diff = num - p.to_i
    excluding_preamble = (preamble[0...i] + preamble[i+1..-1]).map(&:to_i)
    if excluding_preamble.include?(diff)
      exists = true
      break
    end
  end
  exists
end

input.each do |num|
  if preamble.length == 25
    num = num.to_i
    unless pairs_exist(preamble, num)
      puts "----"
      invalid_key = num
      break
    end
  end

  preamble << num

  if preamble.length > 25
    preamble.shift
  end
end

input = input.map(&:to_i)
input.each_with_index do |num, i|
  sum = 0
  sum_end_index = i
  while(sum < invalid_key)
    sum += input[sum_end_index]
    sum_end_index += 1
  end

  if sum == invalid_key
    range = input[i..sum_end_index]
    puts "==="
    puts range.min + range.max
    break
  end
end
