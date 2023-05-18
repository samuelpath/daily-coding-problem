# The maximum sum subarray problem consists in finding the maximum sum of a contiguous subsequence in an array or list of integers:

#   maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
#   -- should be 6: [4, -1, 2, 1]
# Easy case is when the list is made up of only positive numbers and the maximum sum is the sum of the whole array.
# If the list is made up of only negative numbers, return 0 instead.

# Empty list is considered to have zero greatest sum. Note that the empty list or array is also a valid sublist/subarray.

require 'test-unit'
require 'pry'

def max_sequence(arr)
  return 0 if arr.all?(&:negative?)
  return arr.sum if arr.all?(&:positive?)
  
  max = 0
  0.upto(arr.size - 1).each do |i|
    acc = arr[i]
    max = [max, acc].max
    (i + 1).upto(arr.size - 1).each do |j|
      acc += arr[j]
      max = [max, acc].max
    end
  end
  max
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(max_sequence([]), 0)
    assert_equal(max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]), 6)
    assert_equal(max_sequence([11]), 11)
    assert_equal(max_sequence([-32]), 0)
    assert_equal(max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]), 12)
    assert_equal(max_sequence([23, -11, -7, -4, -5, -21, 14, -20, -23, -15]), 23)
    assert_equal(max_sequence([-21, -14, 12, -20, 13, -18, 3, -5, 10, -16, 21]), 21)
  end
end
