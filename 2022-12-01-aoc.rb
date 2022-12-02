require 'pry'

# Advent Of Code 2022 Day 1: https://adventofcode.com/2022/day/1

######### SOLUTIONS #########

class Day01
  def initialize(input)
    @total_calories_by_elf = input.split("\n\n").map { |group| group.split("\n").map(&:to_i).sum }
  end

  def part1
    @total_calories_by_elf.max
  end

  def part2
    @total_calories_by_elf.max(3).sum
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day01Test < Minitest::Test
      def test_total_calories_by_elf
        sample_input = StringIO.new("1000\n2000\n3000\n\n\n4000\n\n\n5000\n6000\n\n\n7000\n8000\n9000\n\n\n10000\n").string
        day01 = Day01.new(sample_input)
        assert_equal([6000, 4000, 11000, 24000, 10000], day01.instance_variable_get(:@total_calories_by_elf))
      end

      def test_part_1
        day01 = Day01.new(input)
        assert_equal(74198, day01.part1)
      end

      def test_part_2
        day01 = Day01.new(input)
        assert_equal(209914, day01.part2)
      end

      def input
        File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    day01 = Day01.new(input)
    p "Part 1: #{day01.part1}"
    p "Part 2: #{day01.part2}"
  end
end