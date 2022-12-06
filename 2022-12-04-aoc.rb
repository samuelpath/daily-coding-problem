require 'pry'

# Advent Of Code 2022 Day 4: https://adventofcode.com/2022/day/4

######### SOLUTIONS #########

class Day04
  class << self
    def part1(input)
      input
        .split
        .select { |pair| one_contains_other(pair) }
        .count
    end

    def part2(input)
      input
        .split
        .select { |pair| ranges_overlap(pair) }
        .count
    end

    def one_contains_other(pair)
      a1, a2, b1, b2 = extract_bounds_from_pair_str(pair)
      (a1 >= b1 && a2 <= b2) || (b1 >= a1 && b2 <= a2)
    end

    def ranges_overlap(pair)
      a1, a2, b1, b2 = extract_bounds_from_pair_str(pair)
      (a1 <= b1 && b1 <= a2) || (a1 <= b2 && b2 <= a2) || (b1 <= a1 && a1 <= b2) || (b1 <= a2 && a2 <= b2)
    end

    def extract_bounds_from_pair_str(pair_str)
      pair_str.split(",").map{ |range| range.split("-") }.flatten.map(&:to_i)
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day04Test < Minitest::Test
      def test_one_contains_other
        assert_equal(false, Day04.one_contains_other("2-4,6-8"))
        assert_equal(false, Day04.one_contains_other("2-3,4-5"))
        assert_equal(false, Day04.one_contains_other("5-7,7-9"))
        assert_equal(true, Day04.one_contains_other("2-8,3-7"))
        assert_equal(true, Day04.one_contains_other("6-6,4-6"))
        assert_equal(false, Day04.one_contains_other("2-6,4-8"))
      end

      def test_ranges_overlap
        assert_equal(false, Day04.ranges_overlap("2-4,6-8"))
        assert_equal(false, Day04.ranges_overlap("2-3,4-5"))
        assert_equal(true, Day04.ranges_overlap("5-7,7-9"))
        assert_equal(true, Day04.ranges_overlap("2-8,3-7"))
        assert_equal(true, Day04.ranges_overlap("6-6,4-6"))
        assert_equal(true, Day04.ranges_overlap("2-6,4-8"))
      end

      def test_extract_bounds_from_pair_str
        assert_equal([2, 4, 6, 8], Day04.extract_bounds_from_pair_str("2-4,6-8"))
        assert_equal([2, 3, 4, 5], Day04.extract_bounds_from_pair_str("2-3,4-5"))
        assert_equal([5, 7, 7, 9], Day04.extract_bounds_from_pair_str("5-7,7-9"))
        assert_equal([2, 8, 3, 7], Day04.extract_bounds_from_pair_str("2-8,3-7"))
        assert_equal([6, 6, 4, 6], Day04.extract_bounds_from_pair_str("6-6,4-6"))
        assert_equal([2, 6, 4, 8], Day04.extract_bounds_from_pair_str("2-6,4-8"))
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day04.part1(input)}"
    p "Part 2: #{Day04.part2(input)}"
  end
end