# n  n/2 (n is even)
# n  3n + 1 (n is odd)

steps_hash = {}

current_max_steps = 0
current_max_steps_number = nil

1.upto(1000000).each{ |num|

  startnum = num

  mysteps = 0
  while num != 1
    if steps_hash.has_key?(num)
      mysteps += steps_hash[num]
      break
    end
    if num % 2 == 0
      num = num / 2
    else
      num = (3 * num) + 1
    end
    mysteps += 1
  end

  steps_hash[startnum] = mysteps

  if mysteps > current_max_steps
    current_max_steps = mysteps
    current_max_steps_number = startnum
  end

}

puts current_max_steps_number
puts current_max_steps
