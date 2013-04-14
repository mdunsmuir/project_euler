STORED_FACTORS = {}

def factor(num)

  return STORED_FACTORS[num] if STORED_FACTORS[num]

  factors = []
  sofar = 1
  targ = num

  while sofar < targ do
    try = 2

    while not (num % try == 0) do
      try += 1
    end

    factors << try
    sofar = sofar * try
    num = num / try
    factors << num
  end

  factors.sort!
  factors.uniq!
  STORED_FACTORS[num] = factors

end

cap = ARGV.shift.to_i

puts factor(cap).inspect
exit


num = cap

while true do

  factors = factor(num)
  factors.delete_if{ |thing| thing > cap }

  if factors.size == cap
    puts(num)
    exit
  end

  num += 1

end
