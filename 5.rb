input = File.read('5.txt').split("\n")

puts "#{input.length} lines of input"

TOTAL_ROWS = 128
TOTAL_COLS = 8

seat_ids = []

def upper_half(current_lower, current_upper)
  new_lower = (current_upper + current_lower) / 2 + 1
  # puts "taking upper: " + [new_lower, current_upper].to_s
  [new_lower, current_upper]
end

def lower_half(current_lower, current_upper)
  new_upper = (current_upper + current_lower) / 2
  # puts "taking lower: " + [current_lower, new_upper].to_s
  [current_lower, new_upper]
end

# ins = "FBFBBFFRLR"
input.each do |ins|
  row_ins = ins[0..6]
  col_ins = ins[7..10]

  upper_row_limit = TOTAL_ROWS - 1
  lower_row_limit = 0
  row_ins.split(//).each do |ri|
    if ri == 'F'
      lower_row_limit, upper_row_limit = lower_half(lower_row_limit, upper_row_limit)
    elsif ri =='B'
      lower_row_limit, upper_row_limit = upper_half(lower_row_limit, upper_row_limit)
    else
      raise 'ri was not F or B'
    end
  end

  raise 'rows did not converge' unless upper_row_limit == lower_row_limit

  upper_col_limit = TOTAL_COLS - 1
  lower_col_limit = 0
  col_ins.split(//).each do |ci|
    if ci == 'L'
      lower_col_limit, upper_col_limit = lower_half(lower_col_limit, upper_col_limit)
    elsif ci == 'R'
      lower_col_limit, upper_col_limit = upper_half(lower_col_limit, upper_col_limit)
    else
      raise 'ci was not L or R'
    end
  end

  raise 'rows did not converge' unless upper_col_limit == lower_col_limit

  seat_id = upper_row_limit * 8 + upper_col_limit
  seat_ids << seat_id
end

puts seat_ids.max
puts (0..seat_ids.max).to_a - seat_ids
