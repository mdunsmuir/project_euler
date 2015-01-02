class Fixnum

  def prime?

    @@iprime ||= 2
    @@prime_hash ||= {2 => 2}
    if self <= @@iprime 
      if @@prime_hash[self] 
        return @@prime_hash[self] 
      else
        return nil
      end
    end

    (@@iprime + 1).upto(self) do |num|
      root = Math.sqrt(num).floor
      catch :notprime do
        @@prime_hash.each_key do |prime|
          break if prime > root
          throw :notprime if num % prime == 0
        end
        @@prime_hash[num] = num
        @@iprime = num
      end
    end

    return @@prime_hash[self]
  end
  
end

time = Time.now
bound = ARGV.shift.to_i

max = 0
max_a = nil
max_b = nil
(-1 * bound).upto(bound) do |b|
  next unless b.prime?
  (-1 * bound).upto(bound) do |a|
    next unless (1 + a + b).prime?
    n = 0
    while (n**2 + a * n + b).prime?
      n += 1
    end
    if n > max
      max = n
      max_a = a
      max_b = b
    end
  end
end

puts "product: #{max_a * max_b}"
puts "finished in #{Time.now - time} seconds"
