require 'pry'

# Advent Of Code 2022 Day 2: https://adventofcode.com/2022/day/2

######### SOLUTIONS #########

class Day02
  MAPPING_NAIVE_XYZ_TO_ABC = {
    "X" => "A",
    "Y" => "B",
    "Z" => "C"
  }
  MAPPING_ACTION_LETTER_TO_SHAPE = {
    "A" => :rock,
    "B" => :paper,
    "C" => :scissors
  }
  MAPPING_SHAPE_SCORE = {
    :rock => 1,
    :paper => 2,
    :scissors => 3
  }
  MAPPING_XYZ_TO_SHAPE = {
    "X" => :lose,
    "Y" => :draw,
    "Z" => :win
  }
  MAPPING_LOSER_WINNER = {
    :scissors => :rock,
    :paper => :scissors,
    :rock => :paper
  }
  MAPPING_WINNER_LOSER = {
    :rock => :scissors,
    :scissors => :paper,
    :paper => :rock
  }
  LOSS_SCORE = 0
  DRAW_SCORE = 3
  WIN_SCORE = 6

  class << self
    def part1(input)
      input
        .split("\n") # [["C Z"], ["C Y"], ["B X"]…
        .map(&:split) # [["C", "Z"], ["C", "Y"], ["B", "X"]…
        .map { |round_initial_letters| naive_replace_XYZ_by_ABC(round_initial_letters) } # [["C", "C"], ["C", "B"], ["B", "A"]…
        .map { |round_action_letters| replace_action_letters_by_shapes(round_action_letters) } # [[:scissors, :scissors], [:scissors, :paper], [:paper, :rock]…
        .map { |round_shapes| get_score_from_round_shapes(round_shapes) } # [6, 9, 1…
        .sum
    end

    def part2(input)
      input
        .split("\n") # [["C Z"], ["C Y"], ["B X"]…
        .map(&:split) # [["C", "Z"], ["C", "Y"], ["B", "X"]…
        .map { |round| replace_XYZ_action_by_shape_to_play(round) } # [[:scissors, :scissors], [:scissors, :paper], [:paper, :rock]…
        .map { |round_shapes| get_score_from_round_shapes(round_shapes) } # [6, 9, 1…
        .sum
    end

    def naive_replace_XYZ_by_ABC(round_initial_letters)
      [round_initial_letters.first, MAPPING_NAIVE_XYZ_TO_ABC[round_initial_letters.last]]
    end

    def replace_action_letters_by_shapes(round_action_letters)
      round_action_letters.map { |action_letter| MAPPING_ACTION_LETTER_TO_SHAPE[action_letter] }
    end

    def get_score_from_round_shapes(round)
      opponent_shape, self_shape = round
      get_round_total_score(opponent_shape, self_shape)
    end

    def get_round_total_score(opponent_shape, self_shape)
      MAPPING_SHAPE_SCORE[self_shape] + get_score_from_round_outcome(opponent_shape, self_shape)
    end

    def get_score_from_round_outcome(opponent_shape, self_shape)
      if (is_draw?(opponent_shape, self_shape))
        DRAW_SCORE
      elsif (is_self_winning_shape?(opponent_shape, self_shape))
        WIN_SCORE
      else
        LOSS_SCORE
      end
    end

    def is_draw?(opponent_shape, self_shape)
      self_shape == opponent_shape
    end

    def is_self_winning_shape?(opponent_shape, self_shape)
      (self_shape == :rock && opponent_shape == :scissors) ||
      (self_shape == :scissors && opponent_shape == :paper) ||
      (self_shape == :paper && opponent_shape == :rock)
    end

    def replace_XYZ_action_by_shape_to_play(round)
      opponent_shape = MAPPING_ACTION_LETTER_TO_SHAPE[round.first]
      self_shape = MAPPING_XYZ_TO_SHAPE[round.last]
      if (self_shape == :draw)
        [opponent_shape, opponent_shape]
      elsif (self_shape == :win)
        [opponent_shape, MAPPING_LOSER_WINNER[opponent_shape]]
      elsif (self_shape == :lose)
        [opponent_shape, MAPPING_WINNER_LOSER[opponent_shape]]
      end
    end
  end
end

######### ASSERTIONS #########

if __FILE__ == $0
  if ENV['TEST']
    require 'minitest/autorun'
    require 'stringio'
    class Day01Test < Minitest::Test
      def test_get_round_total_score
        # Losses
        assert_equal(1, Day02.get_round_total_score(:paper, :rock))
        assert_equal(2, Day02.get_round_total_score(:scissors, :paper))
        assert_equal(3, Day02.get_round_total_score(:rock, :scissors))
        # Draws
        assert_equal(4, Day02.get_round_total_score(:rock, :rock))
        assert_equal(5, Day02.get_round_total_score(:paper, :paper))
        assert_equal(6, Day02.get_round_total_score(:scissors, :scissors))
        # Wins
        assert_equal(7, Day02.get_round_total_score(:scissors, :rock))
        assert_equal(8, Day02.get_round_total_score(:rock, :paper))
        assert_equal(9, Day02.get_round_total_score(:paper, :scissors))
      end

      def test_part_1
        assert_equal(9241, Day02.part1(input))
      end

      def test_part_2
        assert_equal(14610, Day02.part2(input))
      end

      def input
        File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
      end
    end
  else
    input = File.read("./aoc-input/#{File::basename($0, File.extname($0))}-input.txt")
    p "Part 1: #{Day02.part1(input)}"
    p "Part 2: #{Day02.part2(input)}"
  end
end