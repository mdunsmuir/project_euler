#
#    1 Jan 1900 was a Monday.
#    Thirty days has September,
#    April, June and November.
#    All the rest have thirty-one,
#    Saving February alone,
#    Which has twenty-eight, rain or shine.
#    And on leap years, twenty-nine.
#    A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
#

# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

MONTH_DAYS = [31, nil, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

nsundays = 0

yr = 1900
mo = 1
daycount = 1
while yr < 2001 do
  nsundays += 1 if daycount % 7 == 0 and yr >= 1901
  if mo == 2
    if yr % 4 == 0 and ((yr % 100 != 0) or (yr % 400 == 0))
      daycount += 29
    else
      daycount += 28
    end
  else
    daycount += MONTH_DAYS[mo - 1]
  end
  if mo == 12
    yr += 1
    mo = 1
  else
    mo += 1
  end
end

puts nsundays
