
# If the numbers 1 to 5 are written out in words: one, two, 
# three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive 
# were written out in words, how many letters would be used?


# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) 
# contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use 
# of "and" when writing out numbers is in compliance with British usage.


CONVERSION = { 1 => "one",
							 2 => "two",
							 3 => "three",
							 4 => "five",
							 5 => "five",
							 6 => "six",
							 7 => "seven",
							 8 => "eight",
							 9 => "nine",
							10 => "ten",
							11 => "eleven",
							12 => "twelve",
							13 => "thirteen",
							14 => "fourteen",
							15 => "fifteen",
							16 => "sixteen",
							17 => "seventeen",
							18 => "eighteen",
							19 => "nineteen",
							20 => "twenty",
							30 => "thirty",
							40 => "forty",
							50 => "fifty",
							60 => "sixty",
							70 => "seventy",
							80 => "eighty",
							90 => "ninety" }


array = []

1.upto(1000) do |number|
	temp = []

	if number >= 1000
		temp << CONVERSION[number/1000] + "thousand"
		number = number % 1000
	end
	
	if number >= 100 
		temp << CONVERSION[number/100] + "hundred"
		number = number % 100
		temp << "and" unless number == 0 
	end

	if number >=20
		temp << CONVERSION[(number/10)*10]
		number = number % 10
	end

	if (1..19).include?(number)
		temp << CONVERSION[number]
	end

	array << temp.join

end

puts array.join.length