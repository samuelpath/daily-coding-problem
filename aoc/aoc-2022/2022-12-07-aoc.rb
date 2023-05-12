require 'pry'

# Advent Of Code 2022 Day 07: https://adventofcode.com/2022/day/07

######### SOLUTIONS #########

class Day07
  @dir_sizes = []

  class << self
    TOTAL_DISK_SPACE = 70_000_000
    DISK_SPACE_REQUIRED = 30_000_000
    
    def part1(input)
      hash = parse_to_hash(input)
      generate_dir_sizes(hash)
      @dir_sizes.select { _1 <= 100_000 }.sum
    end

    def part2(input)
      hash = parse_to_hash(input)
      generate_dir_sizes(hash)
      
      used_space = @dir_sizes.max
      unused_space = TOTAL_DISK_SPACE - used_space
      space_to_free = DISK_SPACE_REQUIRED - unused_space

      @dir_sizes.sort.each do |size|
        if (size >= space_to_free)
          return size
        end
      end
    end

    def parse_to_hash(input)
      dir_path = []
      hash = {}
      current_node = hash

      input.split("\n").each do |line|
        if (match = line.match(/^\$ cd (?<dir>.+)$/))
          dir = match["dir"]
          if (dir == "..")
            dir_path.pop
            current_node = hash.dig(*dir_path)
          else
            if (!current_node.key?(dir))
              current_node[dir] = {}
            end
            current_node = current_node[dir]
            dir_path << dir
          end
        elsif (match = line.match(/^(?<size>\d+) (?<filename>.+)$/))
          current_node[match["filename"]] = match["size"].to_i
        end
      end
      hash
    end

    def generate_dir_sizes(hash)
      size = 0
      hash.each do |key, value|
        if (value.is_a? Integer)
          size += value
        else
          dir_size = generate_dir_sizes(value)
          @dir_sizes << dir_size
          size += dir_size
        end
      end
      size
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day07Test < Minitest::Test
      def test_part1
        assert_equal(95_437, Day07.part1(input))
      end

      def test_part2
        assert_equal(24_933_642, Day07.part2(input))
      end
      
      def input
        <<EOS
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
EOS
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day07.part1(input)}"
    p "Part 2: #{Day07.part2(input)}"
  end
end