input = File.read('4.txt').split("\n\n")

puts "#{input.length} lines of input"

REQ_KEYS = [
  'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'
]
OPTIONAL_KEY = 'cid'

VALID_EYE_COLORS = [
  'amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'
]

def secondary_validation_passed?(id)
  return false unless id['byr'].to_i >= 1920 && id['byr'].to_i <= 2002

  return false unless id['iyr'].to_i >= 2010 && id['iyr'].to_i <= 2020

  return false unless id['eyr'].to_i >= 2020 && id['eyr'].to_i <= 2030

  matches, scale, unit = id['hgt'].match(/(\d+)(cm|in)/).to_a
  return false unless matches
  if unit == 'cm'
    return false unless scale.to_i >= 150 && scale.to_i <= 193
  else
    return false unless scale.to_i >= 59 && scale.to_i <= 76
  end

  return false unless id['hcl'].match(/#((\d|[a-f]){6})/) && id['hcl'].length == 7

  return false unless VALID_EYE_COLORS.include? id['ecl']

  return false unless id['pid'].match(/(\d{9})/) && id['pid'].length == 9

  return true
end

valid_ids1 = 0
valid_ids2 = 0
input.each do |id|
  fields = id.split("\n").join(" ").split(" ")
  id = {}
  fields.each do |f|
    f = f.split(":")
    id[f[0]] = f[1]
  end

  if REQ_KEYS.all? { |k| id.keys.include? k }
    valid_ids1 += 1
    valid_ids2 += 1 if secondary_validation_passed?(id)
  end
end

puts valid_ids1
puts valid_ids2
