require 'pry'

# Advent Of Code 2022 Day XX: https://adventofcode.com/2022/day/XX

######### SOLUTIONS #########

class DayXX
  class << self
    def part1(input)
      
    end

    def part2(input)
      
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class DayXXTest < Minitest::Test
      
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{DayXX.part1(input)}"
    p "Part 2: #{DayXX.part2(input)}"
  end
end