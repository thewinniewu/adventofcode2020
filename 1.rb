input = File.read('1.txt').split("\n").map(&:to_i)

answer1 = nil
input.each do |num|
  other_num = input.detect { |e| 2020 - num == e }

  unless other_num.nil?
    puts "#{num} + #{other_num} = 2020" 
    answer1 = num * other_num
  end
end
puts answer1

answer2 = nil
input.each do |num|
  break unless answer2.nil?
  difference = 2020 - num 

  remaining_nums = input - [num]
  remaining_nums.each do |rn|
    other_rn = remaining_nums.detect { |e| difference - rn == e }

    unless other_rn.nil?
      puts "#{num} + #{rn} + #{other_rn} = 2020"
      answer2 = num * rn * other_rn
      break
    end
  end
end

puts answer2

