

# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
# The sum of these multiples is 23.

# Find the sum of all the multiples of 3 or 5 below 1000.


high_num = 1000
multiples = [3, 5]
sum = 0

(high_num-1).downto(0) do |num|
  multiples.each do |multiple|
    if num % multiple == 0
      sum += num
      break
    end
  end
end

puts sum # 233168
