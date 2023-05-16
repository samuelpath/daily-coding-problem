# Write a function that takes an array of numbers (integers for the tests) and a target number.
# It should find two different items in the array that, when added together, give the target value.
# The indices of these items should then be returned in a tuple / list (depending on your language) like so: (index1, index2).

# For the purposes of this kata, some tests may have multiple answers; any valid solutions will be accepted.

# The input will always be valid (numbers will be an array of length 2 or greater,
# and all of the items will be numbers; target will always be the sum of two different items from that array).

# Based on: http://oj.leetcode.com/problems/two-sum/

#   two_sum([1, 2, 3], 4) == {0, 2}

require 'test-unit'
require 'pry'

def two_sum(numbers, target)
  0.upto(numbers.size - 1).each do |i|
    (i + 1).upto(numbers.size - 1).each do |j|
      if numbers[i] + numbers[j] == target
        return [i, j]
      end
    end
  end
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(two_sum([1, 2, 3], 4).sort, [0, 2])
    assert_equal(two_sum([1234, 5678, 9012], 14690).sort, [1, 2])
    assert_equal(two_sum([2, 2, 3], 4).sort, [0, 1])
  end
end
