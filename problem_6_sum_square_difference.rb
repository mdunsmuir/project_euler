#
# The sum of the squares of the first ten natural numbers is,
#1^2 + 2^2 + ... + 10^2 = 385
#The square of the sum of the first ten natural numbers is,
#(1 + 2 + ... + 10)2 = 552 = 3025
#Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025  385 = 2640.
#Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
#

top = ARGV.shift.to_i

sosq = 0
sum = 0
1.upto(top){ |num|
  sosq += num**2.0
  sum += num
}

sum = sum**2.0

puts (sosq - sum).abs
