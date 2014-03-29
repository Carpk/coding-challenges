

# 2520 is the smallest number that can be divided by each of the 
# numbers from 1 to 10 without any remainder.

# What is the smallest positive number that is evenly divisible 
# by all of the numbers from 1 to 20?


NUMS = (1..20).to_a
x = 20

until NUMS.map{|i|  i = x % i}.uniq.length == 1
  x += 1
end

# while x%11!=0 || x%12!=0 || x%13!=0 || x%14!=0 || x%15!=0 || x%16!=0 || x%17!=0 || x%18!=0 || x%19!=0
#   x+=1
# end

puts x