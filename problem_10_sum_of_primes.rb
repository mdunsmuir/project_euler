def prime(max)

  primes = [2]
  factors = {}

  num = 3
  while true do

    root = Math.sqrt(num).floor
    isprime = true

    primes.each{ |prime|
      break if prime > root
#      break if prime > num / prime

      if num % prime == 0
        isprime = false
        break
      end
    }

    break if num > max
    primes << num if isprime
    num += 1

  end

  return primes

end

primes = prime(ARGV.shift.to_i)

puts primes.inspect

sum = 0
primes.each{ |prime|
  sum += prime
}

puts sum
