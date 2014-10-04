###

def permute(arr, ipermute)
  npermutations = 1.upto(arr.size).inject(:*)
  raise "#{ipermute} permutations exceeds max permutations for #{arr.size} elements (#{npermutations})" if ipermute > npermutations
  arr = arr.clone
  result = []
  ipermute -= 1
  while arr.size > 1 do
    per = npermutations / arr.size
    result << arr.delete_at(ipermute / per)
    ipermute -= (per * (ipermute / per).floor)
    npermutations = 1.upto(arr.size).inject(:*)
  end
  result << arr[0]
  return result
end

arr = []
0.upto(9){ |i| arr << i }

puts permute(arr, 1000000).join
