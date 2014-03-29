
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

# a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.


x, y, z = 1, 1, 1

while x**2 + y**2 != z**2 || x + y + z != 1000
	if z > y + 200
		y += 1
		z = y
	elsif y > x + 200
		x += 1
		x, y = x, x
	else
		z += 1
	end
end

puts x*y*z