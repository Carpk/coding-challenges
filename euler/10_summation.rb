
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

# Find the sum of all the primes below two million.

num, divisor, sum = 3, 2, 2

while num < 2000000
	if divisor == Math.sqrt(num).round + 1
		sum += num
		num += 2
		divisor = 2
	elsif num % divisor == 0
		num += 2
		divisor = 2
	else
		divisor += 1
  end
end

puts sum