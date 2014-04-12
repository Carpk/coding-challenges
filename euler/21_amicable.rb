
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

1.upto(9999) do |num|
  divisors = []
  Math.sqrt(num).round.downto(1) do |pssbl_dvsr|
    if num % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << num / pssbl_dvsr
    end
  end
 # p divisors
  first_num = divisors[0..-2].reduce(:+)
 # p first_num
  divisors.clear
  Math.sqrt(first_num).round.downto(1) do |pssbl_dvsr|
    if first_num % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << first_num / pssbl_dvsr
    end
  end
  #p divisors
  second_num = divisors[0..-2].reduce(:+)
  #p second_num
  divisors.clear
  Math.sqrt(second_num).round.downto(1) do |pssbl_dvsr|
    if second_num % pssbl_dvsr == 0
      divisors.unshift(pssbl_dvsr)
      divisors << second_num / pssbl_dvsr
    end
  end


  if first_num != second_num && first_num == divisors.reduce(:+) - num
    amicables << second_num
    amicables << first_num 
  end

  # if num != temp && temp > 0 && num > 0 
  #   amicables << temp 
  #   amicables << num
  # end
end

p amicables.uniq.reduce(:+)
