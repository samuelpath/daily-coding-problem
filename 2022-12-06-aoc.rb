require 'pry'

# Advent Of Code 2022 Day 06: https://adventofcode.com/2022/day/06

######### SOLUTIONS #########

class Day06
  class << self
    def part1(input) = find_index_end_of_slice_without_dup(input, 4)

    def part2(input) = find_index_end_of_slice_without_dup(input, 14)

    def find_index_end_of_slice_without_dup(input, signal_size)
      chars = input.chars
      chars_to_check_next = chars.slice(0, signal_size)
      (signal_size..chars.size).each do |i|
        if (chars_to_check_next.size == chars_to_check_next.uniq.size)
          return i
        end
        chars_to_check_next.shift
        chars_to_check_next << chars[i]
      end
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day06Test < Minitest::Test
      def test_part1
        assert_equal(7, Day06.part1("mjqjpqmgbljsphdztnvjfqwrcgsmlb"))
        assert_equal(5, Day06.part1("bvwbjplbgvbhsrlpgdmjqwftvncz"))
        assert_equal(6, Day06.part1("nppdvjthqldpwncqszvftbrmjlhg"))
        assert_equal(10, Day06.part1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"))
        assert_equal(11, Day06.part1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))
      end

      def test_part2
        assert_equal(19, Day06.part2("mjqjpqmgbljsphdztnvjfqwrcgsmlb"))
        assert_equal(23, Day06.part2("bvwbjplbgvbhsrlpgdmjqwftvncz"))
        assert_equal(23, Day06.part2("nppdvjthqldpwncqszvftbrmjlhg"))
        assert_equal(29, Day06.part2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"))
        assert_equal(26, Day06.part2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"))
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day06.part1(input)}"
    p "Part 2: #{Day06.part2(input)}"
  end
end