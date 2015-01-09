

# A palindromic number reads the same both ways. The
# largest palindrome made from the product of
# two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product
# of two 3-digit numbers.


class NumberCruncher

  def initialize
    @x = 999
    @y = 999
  end

  def palindrome_check(num)
    return true if num.length <= 1
    if num[0] == num[-1]
      palindrome_check(num[1..-2])
    else
      false
    end
  end

  def reduce_multiplier
    @x = @y
    @y -= 1
    if @y > 1
      highest
    end
  end

  def highest
    100.times do
      @x -= 1
      # puts "X: #{@x}, Y: #{@y}"
      if palindrome_check((@x * @y).to_s) == true
        return  puts "ANSWER:  #{ @x * @y }"
      end
    end
    reduce_multiplier
  end
end


NumberCruncher.new.highest # 906609
