require 'pry'

# Advent Of Code 2022 Day 05: https://adventofcode.com/2022/day/05

######### SOLUTIONS #########

class Day05
  class << self
    def part1(input)
      stacks_hash = get_stacks_hash(input)

      moves_arr = input.split("\n\n").last.split("\n")
      moves_arr.each do |move|
        crates_to_move, crate_source, crate_destination = move.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)
        crates_to_move.times do
          stacks_hash[crate_destination] << stacks_hash[crate_source].pop
        end
      end

      get_top_crates(stacks_hash)
    end

    def part2(input)
      stacks_hash = get_stacks_hash(input)

      moves_arr = input.split("\n\n").last.split("\n")
      moves_arr.each do |move|
        crates_to_move, crate_source, crate_destination = move.match(/move (\d+) from (\d+) to (\d+)/).captures.map(&:to_i)
        
        tmp_arr = []
        crates_to_move.times do
          tmp_arr << stacks_hash[crate_source].pop
        end
        stacks_hash[crate_destination].concat(tmp_arr.reverse)
      end

      get_top_crates(stacks_hash)
    end

    def get_top_crates(stacks_hash)
      result = ""
      (1..stacks_hash[:number_of_stacks]).each do |i|
        result += stacks_hash[i].last
      end
      result
    end

    def initialize_stacks_hash(number_of_stacks)
      stacks_hash = {}
      (1..number_of_stacks).each do |i|
        stacks_hash[i] = []
      end
      stacks_hash[:number_of_stacks] = number_of_stacks
      stacks_hash
    end

    def get_stacks_hash(input)
      number_of_stacks = get_number_of_stacks(input)
      stacks_hash = initialize_stacks_hash(number_of_stacks)
      get_stack_input_without_stack_number(input).each do |line|
        (1..number_of_stacks).each do |i|
          crate = line[1 + (4* (i-1))]
          stacks_hash[i].unshift(line[1 + (4* (i-1))]) if (crate != " ")
        end
      end
      stacks_hash
    end

    def get_number_of_stacks(input)
      get_stack_input_with_stack_number(input)[-1].to_i
    end

    def get_stack_input_with_stack_number(input)
      input.split(" \n\nmove").first
    end

    def get_stack_input_without_stack_number(input)
      input.split("\n 1").first.split("\n")
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day05Test < Minitest::Test
      def test_part1
        assert_equal("CMZ", Day05.part1(input))
      end

      def test_part2
        assert_equal("MCD", Day05.part2(input))
      end
      
      def input
        <<EOS
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
EOS
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day05.part1(input)}"
    p "Part 2: #{Day05.part2(input)}"
  end
end