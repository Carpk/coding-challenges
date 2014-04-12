
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

1.upto(9999) do |first_num|

  divisors = []
  Math.sqrt(first_num).round.downto(1) do |pssbl_dvsr|
    if first_num % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << first_num / pssbl_dvsr
    end
  end
  second_num = divisors[0..-2].reduce(:+)
 
  divisors.clear
  Math.sqrt(second_num).round.downto(1) do |pssbl_dvsr|
    if second_num % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << second_num / pssbl_dvsr
    end
  end
  compare = divisors[0..-2].reduce(:+)

  divisors.clear
  Math.sqrt(compare).round.downto(1) do |pssbl_dvsr|
    if compare % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << compare / pssbl_dvsr
    end
  end

  if second_num != compare && second_num == divisors[0..-2].reduce(:+)
    unless amicables.include?(compare)
      amicables << compare
      amicables << second_num 
    end
  end
end

# The first few amicable pairs are: (220, 284), (1184, 1210), (2620, 2924), (5020, 5564), (6232, 6368)
p amicables.reduce(:+)

# 31626
