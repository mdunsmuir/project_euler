package main

import(
  "fmt"
)

var dim int = 1001

func main() {
  sum := 1
  var start int
  for i := 1; i <= (dim / 2); i++ {
    start = (i - 1) * 2 + 1
    start *= start
    for j := 1; j <= 4; j++ {
      sum += start + (j * ((i * 2 + 1) - 1))
    }
  }
  fmt.Println(sum)
}
