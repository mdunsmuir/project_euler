1.upto(1000){ |a|
  1.upto(1000){ |b|

    c = Math.sqrt(a**2.0 + b**2.0)

    if a + b + c == 1000
      puts a
      puts b
      puts c
      puts a * b * c
      exit
    end

  }
}
