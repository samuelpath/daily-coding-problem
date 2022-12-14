require File.expand_path(File.dirname(__FILE__) + '/assert')
require 'set'

# Level: Easy
# This problem was recently asked by Google.
# Given a list of numbers and a number k, return whether any two numbers from the list add up to k.
# For example, given [10, 15, 3, 7] and k of 17, return true since 10 + 7 is 17.
# Bonus: Can you do this in one pass?

######### SOLUTIONS #########

# My initial naïve approach
def any_two_numbers_add_up(list, k)
  list.each_with_index do |current_value_to_add, index|
    nb_of_values_to_check_with_current = list.size - index - 1
    index_of_value_to_check_with_current = index + 1
    nb_of_values_to_check_with_current.times do
      if (current_value_to_add + list[index_of_value_to_check_with_current] == k)
        return true
      end
      index_of_value_to_check_with_current += 1
    end
  end
  false
end

# Impressive solution suggested by my colleague Andy Waite
def amazing_one_liner(list, k)
  list.combination(2).map(&:sum).include?(k)
end

# More effective one-liner that stops as soon as a solution is found and doesn't need to compute all pairs up front
def amazing_one_liner_more_efficient(list, k)
  list.combination(2).any? { |a| a.sum == k }
end

# The most time efficient approach (linear time 0(n))
# Manu you rock!
def efficient_approach(list, k)
  set_k_minus_n = Set.new(list.map { |n| k - n })
  list.each do |n|
    if (k / 2 != n && set_k_minus_n.include?(n))
      return true
    end
  end
  false
end

######### ASSERTIONS #########

assert { any_two_numbers_add_up([10, 15, 3, 7], 17) == true }
assert { any_two_numbers_add_up([10, 15, 3, 7], 27) == false }
assert { any_two_numbers_add_up([10, 15, 3, 8], 18) == true }
assert { any_two_numbers_add_up([10, 15, 3, 8], 28) == false }
assert { any_two_numbers_add_up([1, 2], 3) == true }
assert { any_two_numbers_add_up([1, 2], 4) == false }

assert { amazing_one_liner([10, 15, 3, 7], 17) == true }
assert { amazing_one_liner([10, 15, 3, 7], 27) == false }
assert { amazing_one_liner([10, 15, 3, 8], 18) == true }
assert { amazing_one_liner([10, 15, 3, 8], 28) == false }
assert { amazing_one_liner([1, 2], 3) == true }
assert { amazing_one_liner([1, 2], 4) == false }

assert { amazing_one_liner_more_efficient([10, 15, 3, 7], 17) == true }
assert { amazing_one_liner_more_efficient([10, 15, 3, 7], 27) == false }
assert { amazing_one_liner_more_efficient([10, 15, 3, 8], 18) == true }
assert { amazing_one_liner_more_efficient([10, 15, 3, 8], 28) == false }
assert { amazing_one_liner_more_efficient([1, 2], 3) == true }
assert { amazing_one_liner_more_efficient([1, 2], 4) == false }

assert { efficient_approach([10, 15, 3, 7], 17) == true }
assert { efficient_approach([10, 15, 3, 7], 27) == false }
assert { efficient_approach([10, 15, 3, 8], 18) == true }
assert { efficient_approach([10, 15, 3, 8], 28) == false }
assert { efficient_approach([1, 2], 3) == true }
assert { efficient_approach([1, 2], 4) == false }