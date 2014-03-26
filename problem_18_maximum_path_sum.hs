readData fileName =
  map words $ lines (readFile fileName)
