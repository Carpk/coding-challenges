
# By listing the first six prime numbers: 
# 2, 3, 5, 7, 11, and 13, 
# we can see that the 6th prime is 13.

# What is the 10001st prime number?



num, counter = 2, 0
duped = num -1

while counter < 10001
	if duped == 1
		counter += 1
		num += 1
		duped = num -1
	elsif num % duped == 0
		duped = num
		num += 1
	else
		duped -= 1
  end
end

p num - 1