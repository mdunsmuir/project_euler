powers = []

a_range = range(2, 101)
b_max = 101

for a in a_range:
  b = 2
  b_max_temp = b_max

  while b < b_max_temp:
    power = a**b
    powers.append(power)
    b += 1

powers = set(powers)
print len(powers)
