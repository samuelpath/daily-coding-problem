require 'pry'
require 'active_support/all'

# Advent Of Code 2022 Day 4: https://adventofcode.com/2022/day/4

######### SOLUTIONS #########

class Day04
  class << self
    def part1(input)
      input
        .split
        .count { |pair| one_contains_other(pair) }
    end

    def part2(input)
      input
        .split
        .count { |pair| ranges_overlap(pair) }
    end

    def one_contains_other(pair)
      a, b = extract_ranges_from_pair_str(pair)
      a.cover?(b) || b.cover?(a)
    end

    def ranges_overlap(pair)
      a, b = extract_ranges_from_pair_str(pair)
      a.overlaps?(b) || b.overlaps?(a)
    end
    
    def extract_ranges_from_pair_str(pair_str)
      pair_str
        .split(",")
        .flat_map{ |range| range.split("-") }
        .map(&:to_i)
        .each_slice(2)
        .to_a
        .map{ |pair| (pair.first..pair.last) }
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day04Test < Minitest::Test
      def test_part1
        assert_equal(2, Day04.part1(input))
      end

      def test_part2
        assert_equal(4, Day04.part2(input))
      end
      
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

      def extract_ranges_from_pair_str
        assert_equal([(2..4), (6..8)], Day04.extract_bounds_from_pair_str("2-4,6-8"))
        assert_equal([(2..3), (4..5)], Day04.extract_bounds_from_pair_str("2-3,4-5"))
        assert_equal([(5..7), (7..9)], Day04.extract_bounds_from_pair_str("5-7,7-9"))
        assert_equal([(2..8), (3..7)], Day04.extract_bounds_from_pair_str("2-8,3-7"))
        assert_equal([(6..6), (4..6)], Day04.extract_bounds_from_pair_str("6-6,4-6"))
        assert_equal([(2..6), (4..8)], Day04.extract_bounds_from_pair_str("2-6,4-8"))
      end

      def input
        <<EOS
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
EOS
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day04.part1(input)}"
    p "Part 2: #{Day04.part2(input)}"
  end
end