file = io.open("names.txt")

names = {}
for name in string.gmatch(file:read("*a"), "\"%w+\"") do
  gsubd = string.gsub(name, "\"", "")
  table.insert(names, gsubd)
end

file:close()

table.sort(names)
names_score = 0
for i, name in ipairs(names) do
  bytes = table.pack(string.byte(name, 1, string.len(name)))
  local sum = 0
  for i, v in ipairs(bytes) do
    sum = sum + v - 64
  end
  names_score = names_score + sum * i  
end

print(names_score)