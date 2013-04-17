def divisors(num)

  div = []

  1.upto(Math.sqrt(num)){ |i|
    if num % i == 0
      div << i
      div << num / i
    end
  }

  div << num

  div.sort!
  div.uniq!

  return div

end

n = ARGV.shift.to_i

tnum = 1
inum = 2

while divisors(tnum).size <= n do
  tnum += inum
  inum += 1
end

puts tnum
