require 'prime'
require 'set'

LAST_DIGITS = ['1', '3', '7', '9'].to_set

target_size = ARGV.shift.to_i
good = Hash.new

Prime.each do |prime|
  num_str = prime.to_s
  unique_digits = num_str.chars.uniq

  prime_sets = unique_digits.map { |digit|
    0.upto(9).map { |new_digit|
      str = num_str.gsub(digit, new_digit.to_s)
      if checked.include?(str)
        nil
      else
        checked.add(str)
        if str[0] == '0'
          nil
        elsif !LAST_DIGITS.include?(str[-1])
          nil
        else
          num = str.to_i
          if Prime.prime?(num)
            num
          else
            nil
          end
        end
      end
    }.compact
  }.reject { |set| set.length < target_size }

  unless prime_sets.empty?
    puts prime_sets.first.inspect
    break
  end
end
