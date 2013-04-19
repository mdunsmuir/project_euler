-- Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
-- If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

-- For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper 
-- divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

-- Evaluate the sum of all the amicable numbers under 10000.

require("mdpe")

dtab = {}
for i = 1, 9999 do
  table.insert(dtab, mdpe.tabsum(mdpe.divisors(i)))
end

sum = 0
done = {}
for i, v in ipairs(dtab) do
  if dtab[v] == i and not done[v] then
    if not (i == v) then
--      print(tostring(i) .. " " .. tostring(v))
      sum = sum + i
      sum = sum + v
      done[i] = 1
      done[v] = 1
    end
  end
end

print(sum)