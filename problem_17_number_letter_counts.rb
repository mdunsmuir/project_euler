DIGITS = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
TEENS = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
TENS = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
PLACES = ["", "", "hundred", "thousand"]

def written(num)
  num = num.to_s
  str = []
  digits = []
  num.reverse.each_char{ |c| digits << c.to_i }
  teentest = num[-2..-1].to_i
  hundand = true
  shift = 0
  if teentest >= 10 and teentest < 20
    str << TEENS[teentest - 10]
    2.times{ digits.shift }
    shift = 2
  elsif teentest != 0
    hundand = true
  else
    hundand = false
  end
  digits.each_with_index{ |digit, place|
    place += shift
    if place == 1
      str << TENS[digit] unless TENS[digit] == ""
    elsif digit > 0
      str << "and" if place == 2 and hundand
      str << PLACES[place] unless PLACES[place] == ""
      str << DIGITS[digit - 1]
    end
  }

  return str.reverse.join(" ")
end

str = ""

1.upto(1000){ |i|
  str += written(i).gsub(" ", "")
}

puts str.length
