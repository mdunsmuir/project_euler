power = ARGV.shift.to_i
result = 2**power
sum = 0
result.to_s.each_char{ |c| sum += c.to_i }
puts sum
