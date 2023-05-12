require 'pry'
require 'set'

# Advent Of Code 2022 Day 3: https://adventofcode.com/2022/day/3

######### SOLUTIONS #########

class Day03
  UPPER_ASCII_DIFF = 38 # "A".ord - 27
  LOWER_ASCII_DIFF = 96 # "a".ord - 1
  
  class << self
    def part1(input)
      input
        .split("\n") # ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", etc.
        .map { |line| get_letter_in_both_halves(line) } # ["p", "L", "P", "v", "t", "s", etc.
        .map { |letter| map_letter_to_priority(letter) } # [16, 38, 42, 22, 20, 19, etc.
        .sum # 157
    end

    def part2(input)
      input
        .split("\n")
        .each_slice(3)
        .to_a
        .map { |group_of_three| get_common_letter_three_strings(group_of_three) }
        .map { |letter| map_letter_to_priority(letter) }
        .sum
    end

    def get_letter_in_both_halves(str)
      middle_index = str.length/2
      first_half_set = get_letters_set(str.slice(0, middle_index))
      second_half_set = get_letters_set(str.slice(middle_index, middle_index))
      (first_half_set & second_half_set).to_a.first
    end

    def get_common_letter_three_strings(arr)
      set1, set2, set3 = arr.map { |str| get_letters_set(str) }
      (set1 & set2 & set3).to_a.first
    end

    def map_letter_to_priority(letter)
      if (letter == letter.upcase)
        letter.ord - UPPER_ASCII_DIFF
      else
        letter.ord - LOWER_ASCII_DIFF
      end
    end

    def get_letters_set(str)
      Set.new(str.split(""))
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day03Test < Minitest::Test
      def test_part_1
        assert_equal(157, Day03.part1(input))
      end

      def test_part_2
        assert_equal(70, Day03.part2(input))
      end

      def test_get_letter_in_both_halves
        assert_equal("p", Day03.get_letter_in_both_halves("vJrwpWtwJgWrhcsFMMfFFhFp"))
        assert_equal("L", Day03.get_letter_in_both_halves("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"))
        assert_equal("P", Day03.get_letter_in_both_halves("PmmdzqPrVvPwwTWBwg"))
        assert_equal("v", Day03.get_letter_in_both_halves("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn"))
        assert_equal("t", Day03.get_letter_in_both_halves("ttgJtRGJQctTZtZT"))
        assert_equal("s", Day03.get_letter_in_both_halves("CrZsJsPPZsGzwwsLwLmpwMDw"))
      end

      def test_map_letter_to_priority
        assert_equal(16, Day03.map_letter_to_priority("p"))
        assert_equal(38, Day03.map_letter_to_priority("L"))
        assert_equal(42, Day03.map_letter_to_priority("P"))
        assert_equal(22, Day03.map_letter_to_priority("v"))
        assert_equal(20, Day03.map_letter_to_priority("t"))
        assert_equal(19, Day03.map_letter_to_priority("s"))
      end

      def input
        "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw"
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day03.part1(input)}"
    p "Part 2: #{Day03.part2(input)}"
  end
end