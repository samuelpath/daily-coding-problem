require 'pry'

# Advent Of Code 2022 Day 08: https://adventofcode.com/2022/day/08

######### SOLUTIONS #########

class Day08
  class << self
    def part1(input)
      grid = get_grid(input)
      
      visible_from_left, visible_from_top = get_visible_from_left_and_top(grid)
      visible_from_right, visible_from_bottom = get_visible_from_right_and_bottom(grid)

      visible_trees_count = 0
      grid.size.times do |i|
        grid.size.times do |j|
          is_visible = visible_from_left[i][j] || visible_from_top[i][j] || visible_from_right[i][j] || visible_from_bottom[i][j]
          if (visible_from_left[i][j] || visible_from_top[i][j] || visible_from_right[i][j] || visible_from_bottom[i][j])
            visible_trees_count += 1
          end
        end
      end

      visible_trees_count
    end

    def part2(input)
    end

    def get_grid(input)
      input.split("\n")
        .map(&:chars)
        .flatten
        .map(&:to_i)
        .each_slice(input.lines.count)
        .to_a
    end

    def get_visible_from_left_and_top(grid)
      visible_from_left = Array.new(grid.size){ Array.new(grid.size) }
      visible_from_top = Array.new(grid.size){ Array.new(grid.size) }

      tallest_on_top = Array.new(grid.size){ -1 }
      grid
        .each_with_index do |row, i|
          tallest_on_left = -1
          row.each_with_index do |height, j|
            if (j > 0 && grid[i][j-1] > tallest_on_left)
              tallest_on_left = grid[i][j-1]
            end
            if (i > 0 && grid[i-1][j] > tallest_on_top[j])
              tallest_on_top[j] = grid[i-1][j]
            end
            visible_from_left[i][j] = height > tallest_on_left
            visible_from_top[i][j] = height > tallest_on_top[j]
          end
        end
      
      [visible_from_left, visible_from_top]
    end

    def get_visible_from_right_and_bottom(grid)
      visible_from_right = Array.new(grid.size){ Array.new(grid.size) }
      visible_from_bottom = Array.new(grid.size){ Array.new(grid.size) }

      tallest_on_bottom = Array.new(grid.size){ -1 }
      grid
        .to_enum.with_index.reverse_each do |row, i|
          tallest_on_right = -1
          row.to_enum.with_index.reverse_each do |height, j|
            if (j < grid.size - 1 && grid[i][j+1] > tallest_on_right)
              tallest_on_right = grid[i][j+1]
            end
            if (i < grid.size - 1 && grid[i+1][j] > tallest_on_bottom[j])
              tallest_on_bottom[j] = grid[i+1][j]
            end
            visible_from_right[i][j] = height > tallest_on_right
            visible_from_bottom[i][j] = height > tallest_on_bottom[j]
          end
        end

      [visible_from_right, visible_from_bottom]
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day08Test < Minitest::Test
      def test_part1
        assert_equal(21, Day08.part1(input))
      end

      def test_visible_from_left
        grid = Day08.get_grid(input)
        visible_from_left, _ = Day08.get_visible_from_left_and_top(grid)
        visible_from_left_expected = 
          [[true, false, false, true, false],
          [true, true, false, false, false],
          [true, false, false, false, false],
          [true, false, true, false, true],
          [true, true, false, true, false]]
        assert_equal(visible_from_left_expected, visible_from_left)
      end

      def test_visible_from_top
        grid = Day08.get_grid(input)
        _, visible_from_top = Day08.get_visible_from_left_and_top(grid)
        visible_from_top_expected =
          [[true, true, true, true, true],
          [false, true, true, false, false],
          [true, false, false, false, false],
          [false, false, false, false, true],
          [false, false, false, true, false]]
        assert_equal(visible_from_top_expected, visible_from_top)
      end

      def test_visible_from_right
        grid = Day08.get_grid(input)
        visible_from_right,_ = Day08.get_visible_from_right_and_bottom(grid)
        visible_from_right_expected = 
          [[false, false, false, true, true],
          [false, false, true, false, true],
          [true, true, false, true, true],
          [false, false, false, false, true],
          [false, false, false, true, true]]
        assert_equal(visible_from_right_expected, visible_from_right)
      end

      def test_visible_from_bottom
        grid = Day08.get_grid(input)
        _, visible_from_bottom = Day08.get_visible_from_right_and_bottom(grid)
        visible_from_bottom_expected =
          [[false, false, false, false, false],
          [false, false, false, false, false],
          [true, false, false, false, false],
          [false, false, true, false, true],
          [true, true, true, true, true]]
        assert_equal(visible_from_bottom_expected, visible_from_bottom)
      end

      def input
        <<EOS
30373
25512
65332
33549
35390
EOS
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day08.part1(input)}"
    # p "Part 2: #{Day08.part2(input)}"
  end
end