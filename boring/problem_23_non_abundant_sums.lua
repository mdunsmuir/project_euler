---
require("mdpe")

local abundant_numbers = {}
local totalsum = 0

for i = 1, 28123 do
  totalsum = totalsum + i
  local sum = 0
  for i, v in ipairs(mdpe.divisors(i)) do
    sum = sum + v
  end
  if sum > i then
    table.insert(abundant_numbers, i)
  end
end

table.sort(abundant_numbers)

local abundant_sums = {}
local count_out = {}
for i, v in ipairs(abundant_numbers) do
  for j = i, #abundant_numbers do
    local sum = v + abundant_numbers[j]
    if sum > 28123 then
      break
    elseif not abundant_sums[sum] then
      abundant_sums[sum] = true
      totalsum = totalsum - sum      
    end
  end
end

print(totalsum)