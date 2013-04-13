-- 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
-- What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

local cap = tonumber(arg[1])
local num = cap

while 1 do

  local i = 2
  local fail = false
  while i <= cap do
    if not (num % i == 0) then fail = true; break; end
    i = i + 1
  end

  if not fail then
    print(num)
    break
  end

  num = num + 1

end
