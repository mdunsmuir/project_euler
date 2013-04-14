# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?

def prime2(nprime)

  primes = [2]
  factors = {}

  num = 3
  while primes.size < nprime do

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

    primes << num if isprime
    num += 1

    printf("\r%d", primes.size) if primes.size % 1000.0 == 0

  end

  return primes

end

def prime1(nprime)

  primes = [2]
  factors = {}

  num = 3
  while primes.size < nprime do

    root = Math.sqrt(num).floor
    prime = true
    2.upto(root){ |factor|
      if num % factor == 0
        prime = false
        break
      end
    }

    primes << num if prime
    num += 1

#    printf("\r%d", primes.size)

  end

  return primes
end

nprime = ARGV.shift.to_i

#now = Time.now
#prime1(nprime)
#now2 = Time.now
#puts(now2 - now)
primes = prime2(nprime)
#puts(Time.now - now2)
puts primes.inspect

