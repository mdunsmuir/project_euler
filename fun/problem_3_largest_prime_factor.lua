--
-- The prime factors of 13195 are 5, 7, 13 and 29.
-- What is the largest prime factor of the number 600851475143 ?
--

function factor(num)
  local factors = {}
  local sofar = 1
  local targ = num

  while sofar < targ do
    local try = 2

    while not (num % try == 0) do
      try = try + 1
    end
    
    table.insert(factors, try)
    sofar = sofar * try
    num = num / try
  end

  return factors
  
end

factors = factor(600851475143)
table.sort(factors)

for i, v in ipairs(factors) do
  print(v)
end