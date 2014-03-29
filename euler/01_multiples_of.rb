

# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
# The sum of these multiples is 23.

# Find the sum of all the multiples of 3 or 5 below 1000.

sum, x = 0, 0

while x < 1000
  if x % 5 == 0
    sum += x
  elsif x % 3 == 0
    sum += x
  end
  x += 1
end

puts sum