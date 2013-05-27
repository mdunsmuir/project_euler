pre = [1, 1]
cap = []
999.times{ cap << "9" }
cap = cap.join.to_i

iterm = 3
fib = pre[0] + pre[1]
while fib <= cap do
  pre[0] = pre[1]
  pre[1] = fib
  fib = pre[0] + pre[1]
  iterm += 1
end

puts iterm
