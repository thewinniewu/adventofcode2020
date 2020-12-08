input = File.read('8.txt').split("\n")

puts "#{input.length} lines of input"

def parse_line(line)
  line.match(/(acc|jmp|nop)\s(\+|-)(\d+)/).to_a
end

(0..input.length - 1).each do |target_i|
  original_line = input[target_i]
  _, ins, sign, num = parse_line(input[target_i])

  if ins == 'nop'
    input[target_i] = 'jmp'
  elsif ins == "jmp"
    input[target_i] = 'nop'
  end

  i = 0
  visited = {}
  looped = false
  acc = 0

  while(true)
    ins_line = input[i]
    visited[i] = 0 if visited[i].nil?
    visited[i] += 1

    if visited[i] > 1
      looped = true
      break
    end

    if ins_line.nil?
      break
    end

    _, ins, sign, num = parse_line(ins_line)

    if ins == 'acc'
      if sign == '+'
        acc += num.to_i
      elsif sign == '-'
        acc -= num.to_i
      else
        raise 'unexpected sign'
      end
      i += 1
    elsif ins == 'jmp'
       if sign == '+'
        i += num.to_i
      elsif sign == '-'
        i -= num.to_i
      end
    else
      # nop
      i += 1
    end
  end
  puts "looped: #{looped}, acc: #{acc}"

  if looped
    input[target_i] = original_line
  else
    break
  end
end

