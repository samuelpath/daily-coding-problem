require File.expand_path(File.dirname(__FILE__) + '/assert')

# Level: Hard
# This problem was asked by Uber.

# Given an array of integers, return a new array such that each element at index i of the new array
# is the product of all the numbers in the original array except the one at i.
# For example, if our input was [1, 2, 3, 4, 5], the expected output would be [120, 60, 40, 30, 24].
# If our input was [3, 2, 1], the expected output would be [2, 3, 6].
# Follow-up: what if you can't use division?

######### SOLUTIONS #########

# TODO: determine time and space complexity
def initial_approach_with_division(input)
  product_all_numbers = input.reduce(:*)
  output = input.map { |val| product_all_numbers / val }
  output
end

# TODO: determine time and space complexity
def initial_approach_without_division(input)
  output = []
  input.each_with_index do |_, index|
    input_without_current = input.clone
    input_without_current.delete_at(index) # not happy about this non-immutable approach…
    output << input_without_current.reduce(:*)
  end
  output
end

######### ASSERTIONS #########

assert { initial_approach_with_division([1, 2, 3, 4, 5]) == [120, 60, 40, 30, 24] }
assert { initial_approach_with_division([3, 2, 1]) == [2, 3, 6] }

assert { initial_approach_without_division([1, 2, 3, 4, 5]) == [120, 60, 40, 30, 24] }
assert { initial_approach_without_division([3, 2, 1]) == [2, 3, 6] }