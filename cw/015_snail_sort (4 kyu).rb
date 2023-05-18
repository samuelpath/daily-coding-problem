# Given an n x n array, return the array elements arranged from outermost elements to the middle element, traveling clockwise.

# array = [[1,2,3],
#          [4,5,6],
#          [7,8,9]]
# snail(array) #=> [1,2,3,6,9,8,7,4,5]
# For better understanding, please follow the numbers of the next array consecutively:

# array = [[1,2,3],
#          [8,9,4],
#          [7,6,5]]
# snail(array) #=> [1,2,3,4,5,6,7,8,9]

# NOTE: The idea is not sort the elements from the lowest value to the highest;
# the idea is to traverse the 2-d array in a clockwise snailshell pattern.

# NOTE 2: The 0x0 (empty matrix) is represented as en empty array inside an array [[]].

require 'test-unit'
require 'pry'
require 'pry-nav'

def snail(input_arr)
  return [] if input_arr.first.empty?
  
  result_arr = []
  n = input_arr.size
  target_size = n ** 2
  direction = right
  i, j = 0, 0
  right_bound, down_bound = n - 1, n - 1
  left_bound, up_bound = 0, 0

  while result_arr.size < target_size
    result_arr << input_arr[i][j]

    case direction
    when right
      if j < right_bound
        i, j = go_right(i, j)
      else
        direction = down
        up_bound += 1
        i, j = go_down(i, j)
      end
    when down
      if i < down_bound
        i, j = go_down(i, j)
      else
        direction = left
        right_bound -= 1
        i, j = go_left(i, j)
      end
    when left
      if j > left_bound
        i, j = go_left(i, j)
      else
        direction = up
        down_bound -= 1
        i, j = go_up(i, j)
      end
    when up
      if i > up_bound
       i, j = go_up(i, j)
      else
        direction = right
        left_bound += 1
        i, j = go_right(i, j)
      end
    end
  end
  result_arr
end

def go_right(i, j)
  return i, j + 1
end

def go_left(i, j)
  return i, j - 1
end

def go_down(i, j)
  return i + 1, j
end

def go_up(i, j)
  return i - 1, j
end

def right
  [0, 1]
end

def left
  [0, -1]
end

def up
  [-1, 0]
end

def down
  [1, 0]
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(snail([[1,2,3],[4,5,6],[7,8,9]]), [1, 2, 3, 6, 9, 8, 7, 4, 5])
  end
end
