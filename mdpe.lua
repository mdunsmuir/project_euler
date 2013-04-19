
-- table for all these things
mdpe = mdpe or {}

--
-- Function to find all proper divisors of a number
-- includes 1
--
function mdpe.divisors(number)
  
  -- naive solution
  local divisors = { [1] = number }
  for d = 2, math.sqrt(number) do
    if number % d == 0 then
      divisors[d] = number / d
    end
  end

  local all = {}
  for d1, d2 in pairs(divisors) do
    if not (math.sqrt(number) == d1) then
      table.insert(all, d1)
    end
    table.insert(all, d2)
  end
  
  table.sort(all)
  table.remove(all)
  return all
end

--
-- sum values in table
-- table must be continuous integer indexed
--
function mdpe.tabsum(tab)
  local sum = 0
  for i, v in ipairs(tab) do
    sum = sum + v
  end
  return sum
end