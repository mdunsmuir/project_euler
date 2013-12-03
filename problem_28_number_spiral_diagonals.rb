perimend = 1
1.times do |i|
  i += 1
  iside = i * 2 + 1
  perimstart = perimend + 1
  perimend = iside**2
  (perimend - perimstart).times do |j|
    #puts "j: #{j}, q: #{j + 1 + (iside / 2)}"
    puts j if (j + 1 + iside / 2) % (iside - 1) == 0
  end
end
