CACHED = {}

def path(blk, wht)
  key = [blk, wht].sort
  return CACHED[key] if CACHED[key]
  count = 0
  if blk > 1
    count += path(blk - 1, wht)
    count += path(blk, wht - 1) if wht > 0
  else
    count += wht + 1
  end
  CACHED[key] = count
  return count
end

sidelength = ARGV.shift.to_i

now = Time.now
puts "number of paths : " + path(sidelength, sidelength).to_s
puts "time : " + (Time.now - now).to_s

#puts CACHED.inspect
#puts CACHED.size
