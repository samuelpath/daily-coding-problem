# Given an array of positive or negative integers

#  I= [i1,..,in]

# you have to produce a sorted array P of the form

# [ [p, sum of all ij of I for which p is a prime factor (p positive) of ij] ...]

# P will be sorted by increasing order of the prime numbers.
# The final result has to be given as a string in Java, C#, C, C++ 
# and as an array of arrays in other languages.

# Example:
# I = [12, 15] # result = [[2, 12], [3, 27], [5, 15]]
# [2, 3, 5] is the list of all prime factors of the elements of I, hence the result.

# Notes:

# It can happen that a sum is 0 if some numbers are negative!
# Example: I = [15, 30, -45] 5 divides 15, 30 and (-45) so 5 appears in the result,
# the sum of the numbers for which 5 is a factor is 0 so we have [5, 0] in the result amongst others.

# In Fortran - as in any other language - 
# the returned string is not permitted to contain any redundant trailing whitespace:
# you can use dynamically allocated character strings.

require 'test-unit'
require 'pry'
require 'prime'

def sum_of_divided(list)
  hash = {}
  list.each do |num|
    Prime.each do |prime|
      if num % prime == 0
        if hash.key?(prime)
          hash[prime] += num
        else
          hash[prime] = num
        end
      end
  
      if prime > num.abs
        break
      end
    end
  end
  hash.sort
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(sum_of_divided([12, 15]),[ [2, 12], [3, 27], [5, 15] ])
    assert_equal(sum_of_divided([15, 12]),[ [2, 12], [3, 27], [5, 15] ])
    assert_equal(sum_of_divided([15, 21, 24, 30, -45]), [[2, 54], [3, 45], [5, 0], [7, 21]])
    assert_equal(sum_of_divided([-29804, -4209, -28265, -72769, -31744]), [[2, -61548], [3, -4209], [5, -28265], [23, -4209], [31, -31744], [53, -72769], [61, -4209], [1373, -72769], [5653, -28265], [7451, -29804]])
  end
end
