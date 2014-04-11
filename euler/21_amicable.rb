
# Let d(n) be defined as the sum of proper divisors 
# of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b 
# are an amicable pair and each of a and b are called 
# amicable numbers.

# For example, the proper divisors of 220 
# are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; 
# therefore d(220) = 284. The proper divisors of 284 
# are 1, 2, 4, 71 and 142; so d(284) = 220.

# Evaluate the sum of all the amicable numbers under 10000.

amicables = []

1.upto(220) do |num|
  divisors = []
  Math.sqrt(num).round.downto(1) do |pssbl_dvsr|
    if num % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << num / pssbl_dvsr
    end
  end
  
  pssbl_amica = divisors.reduce(:+) - num
  divisors.clear
  Math.sqrt(pssbl_amica).round.downto(1) do |pssbl_dvsr|
    if pssbl_amica % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << pssbl_amica / pssbl_dvsr
    end
  end
  temp = divisors.reduce(:+) - num
  if num != temp && temp > 0 && num > 0 
    amicables << temp 
    amicables << num
  end
end

p amicables

