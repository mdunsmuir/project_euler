--
-- A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 99.
-- Find the largest palindrome made from the product of two 3-digit numbers.
--

local n1_max = 999
local n1 = n1_max
local n2 = 999
local palins = {}

while n2 > 99 do

  while n1 > 99 do
    
    local product = tostring(n1 * n2)
    if string.sub(product, 0, string.len(product) / 2) == string.reverse(string.sub(product, -string.len(product) / 2, -1)) then
      table.insert(palins, n1 * n2)
    end

    n1 = n1 - 1
    
  end

  n1_max = n1_max - 1
  n1 = n1_max
  n2 = n2 - 1

end

table.sort(palins)

print(palins[#palins])