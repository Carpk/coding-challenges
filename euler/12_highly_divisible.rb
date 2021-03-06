
# The sequence of triangle numbers is generated by adding the natural numbers. So the 
# 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:

# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

# Let us list the factors of the first seven triangle numbers:

#  1: 1
#  3: 1,3
#  6: 1,2,3,6
# 10: 1,2,5,10
# 15: 1,3,5,15
# 21: 1,3,7,21
# 28: 1,2,4,7,14,28
# We can see that 28 is the first triangle number to have over five divisors.

# What is the value of the first triangle number to have over five hundred divisors?


divisors, max = [], 0

until divisors.length > 500
	divisors.clear
	max += 1 
	triangle_num = (0..max).to_a.reduce(:+)
	numerator = 1
	until numerator > Math.sqrt(triangle_num)
	  if triangle_num % numerator == 0
	  	divisors << numerator
	  	divisors << triangle_num / numerator
	  end
	  numerator += 1
	end
end

p divisors.max 
