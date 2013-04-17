# -*- coding: utf-8 -*-
#
# n! means n × (n − 1) × ... × 3 × 2 × 1
# For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
# Find the sum of the digits in the number 100!
#

num = ARGV.shift.to_i

product = 1

while num > 1 do
  product *= num
  num -= 1
end

sum = 0
product.to_s.each_char{ |c| sum += c.to_i }
puts sum
