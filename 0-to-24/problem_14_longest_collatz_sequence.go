package main

import "fmt"

func CollatzNext(num int) int {
  if num % 2 == 0 {
    return num / 2
  } else {
    return (3 * num) + 1
  }
}

func main() {
  imax, countmax := 0, 0
  counts := make(map[int]int)
  for i := 1; i < 1000000; i++ {
    mycount, inum := 0, i
    for inum != 1 {
      inumcount, present := counts[inum]
      if present {
        inum = 1
        mycount += inumcount
      } else {
        inum = CollatzNext(inum)
        mycount ++
      }
    }
    counts[i] = mycount
    if mycount > countmax {
      imax, countmax = i, mycount
    }
  }
  fmt.Println(imax)
}
