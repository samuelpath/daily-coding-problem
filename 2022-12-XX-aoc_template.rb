require 'pry'

# Advent Of Code 2022 Day X: https://adventofcode.com/2022/day/X

######### INSTRUCTIONS #########



######### SOLUTIONS #########

class DayXX
  def initialize(input)
    
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day01Test < Minitest::Test
      
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    dayXX = DayXX.new(input)
    p "Part 1: #{dayXX.part1}"
    p "Part 2: #{dayXX.part2}"
  end
end