def recip3(den, places = 10)
  n = 1
  quotient = []
  remainders = {}
  remainder = nil
  place = 0
  while remainder != 0 do
    while n / den < 1 do
      quotient << "0"
      n *= 10
      place += 1
    end
    remainder = n - (den * (n / den))
    return place - remainders[remainder] if remainders[remainder]
    quotient << (n / den).to_s
    remainders[remainder] = place if place > 0
    n = remainder * 10
    place += 1
  end
  return 0
end

t = Time.now
places = {}

1.upto(999) do |i|
  places[recip3(i)] = i
end

puts places[places.keys.max]
puts "ran in #{Time.now - t} s"
