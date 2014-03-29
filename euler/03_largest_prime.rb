
# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

divisors, primes, x = [], [], 1

while x < 500000
  if 600851475143 % x == 0
    y = 1
    while y < x
      if x % y == 0
        divisors << x
      end
      y += 1
    end
  end
  x += 1
end

divisors.each{|x| primes << x if divisors.count(x) == 1}

puts primes.last

