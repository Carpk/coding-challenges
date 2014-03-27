
# Each new term in the Fibonacci sequence is generated 
# by adding the previous two terms. By starting with 1 
# and 2, the first 10 terms will be:

# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

# By considering the terms in the Fibonacci sequence 
# whose values do not exceed four million, find the sum 
# of the even-valued terms.

a, b, c = 0, 1, 1
even_sum = 0

while c < 4000000
  a = b + c
  b, c = c, a
  if a % 2 == 0
    even_sum += a
  end
end

puts even_sum