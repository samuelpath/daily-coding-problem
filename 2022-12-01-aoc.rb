require 'pry'

# Advent Of Code 2022 Day 1: https://adventofcode.com/2022/day/1

######### INSTRUCTIONS #########

# --- Day 1: Calorie Counting ---
# --- Part One ---
# The Elves take turns writing down the number of Calories contained by the various meals, snacks, rations, etc. 
# that they've brought with them, one item per line.
# Each Elf separates their own inventory from the previous Elf's inventory (if any) by a blank line.
# For example, suppose the Elves finish writing their items' Calories and end up with the following list:

# 1000
# 2000
# 3000

# 4000

# 5000
# 6000

# 7000
# 8000
# 9000

# 10000

# This list represents the Calories of the food carried by five Elves:

# The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
# The second Elf is carrying one food item with 4000 Calories.
# The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
# The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
# The fifth Elf is carrying one food item with 10000 Calories.
# In case the Elves get hungry and need extra snacks, they need to know which Elf to ask: 
# they'd like to know how many Calories are being carried by the Elf carrying the most Calories.
# In the example above, this is 24000 (carried by the fourth Elf).

# Find the Elf carrying the most Calories.
# How many total Calories is that Elf carrying?

# --- Part Two ---
# By the time you calculate the answer to the Elves' question,
# they've already realized that the Elf carrying the most Calories of food might eventually run out of snacks.
# To avoid this unacceptable situation, the Elves would instead like to know the total Calories
# carried by the top three Elves carrying the most Calories.
# That way, even if one of those Elves runs out of snacks, they still have two backups.
# In the example above, the top three Elves are the fourth Elf (with 24000 Calories),
# then the third Elf (with 11000 Calories), then the fifth Elf (with 10000 Calories).
# The sum of the Calories carried by these three elves is 45000.
# Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?

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
        input = StringIO.new("1000\n2000\n3000\n\n\n4000\n\n\n5000\n6000\n\n\n7000\n8000\n9000\n\n\n10000\n").string
        day01 = Day01.new(input)
        assert_equal([6000, 4000, 11000, 24000, 10000], day01.instance_variable_get(:@total_calories_by_elf))
      end

      def test_part_1
        input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
        day01 = Day01.new(input)
        assert_equal(day01.part1, 74198)
      end

      def test_part_2
        input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
        day01 = Day01.new(input)
        assert_equal(day01.part2, 209914)
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    day01 = Day01.new(input)
    p "Part 1: #{day01.part1}"
    p "Part 2: #{day01.part2}"
  end
end