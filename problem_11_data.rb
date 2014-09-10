lines = IO.readlines("problem_11_data.txt")
lines.collect!{ |line| line.strip.split(" ").collect{ |num| num.to_i } }

width = lines.first.size
height = lines.size

max = 0

# up/down/diag
0.upto(height - 5){ |j|

  0.upto(width - 5){ |i|

    udproduct = 1
    ul2lrproduct = 1
    ll2urproduct = 1

    0.upto(3){ |add|
      udproduct *= lines[j + add][i]
      ul2lrproduct *= lines[j + add][i + add]
      ll2urproduct *= lines[j + 3 - add][i + add]
    }

    max = udproduct if udproduct > max
    max = ul2lrproduct if ul2lrproduct > max
    max = ll2urproduct if ll2urproduct > max

  }

  (width - 4).upto(width - 1){ |i|
    udproduct = 1
    0.upto(3){ |add|
      udproduct *= lines[j + add][i]
    }

    max = udproduct if udproduct > max

  }

}

puts max
