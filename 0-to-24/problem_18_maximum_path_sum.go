package main

import(
  "fmt"
  "os"
  "strings"
  "strconv"
  "io/ioutil"
)

func IntMax(num1, num2 int) int {
  if num1 > num2 {
    return num1
  } else {
    return num2
  }
}

func main() {

  if len(os.Args) < 2 {
    fmt.Println("usage: script <data file>")
    return
  }

  filename := os.Args[1]
  data, err := ioutil.ReadFile(filename)

  if err != nil {
    fmt.Println(err.Error())
    return
  }

  lines := strings.Split(string(data), "\n")
  line_arrays := make([][]int, len(lines) - 1)

  for i := 0; i < len(lines) - 1; i++ {

    line_nums := strings.Split(lines[i], " ")
    line_arrays[i] = make([]int, i + 1)

    for j := 0; j < i + 1; j++ {
      k, _ := strconv.Atoi(line_nums[j])
      line_arrays[i][j] = k
    }

  }

  // io done  

  for i := len(line_arrays) - 2; i >= 0; i-- {

    iarr := line_arrays[i]
    for j := 0; j < len(line_arrays[i]); j++ {
      iarr[j] += IntMax(line_arrays[i + 1][j], line_arrays[i + 1][j + 1])
    }

  }

  fmt.Println(line_arrays[0][0])
}
