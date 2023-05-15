# You are given an array (which will have a length of at least 3, but could be very large) containing integers.
# The array is either entirely comprised of odd integers or entirely comprised of even integers except for a single integer N.
# Write a method that takes the array as an argument and returns this "outlier" N.

# Examples
# [2, 4, 0, 100, 4, 11, 2602, 36]
# Should return: 11 (the only odd number)

# [160, 3, 1719, 19, 11, 13, -21]
# Should return: 160 (the only even number)

require 'test-unit'

def find_outlier(integers)
  look_for_odd = integers.map { |int| int % 2 }.sum === 1
   
  integers.find do |int|
    look_for_odd ? int.odd? : int.even?
  end
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(find_outlier([0, 1, 2]), 1)
    assert_equal(find_outlier([1, 2, 3]), 2)
  end
end
