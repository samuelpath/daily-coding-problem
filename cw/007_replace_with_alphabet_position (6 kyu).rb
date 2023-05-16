# Welcome.

# In this kata you are required to, given a string, replace every letter with its position in the alphabet.

# If anything in the text isn't a letter, ignore it and don't return it.

# "a" = 1, "b" = 2, etc.

# Example
# alphabet_position("The sunset sets at twelve o' clock.")
# Should return "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11" ( as a string )

require 'test-unit'

def alphabet_position(text)
  text
    .split('')
    .map(&:downcase)
    .map { |symbol| symbol.ord - 'a'.ord + 1 }
    .select { |rank| rank > 0 && rank < 27 }
    .join(' ')
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(alphabet_position("The sunset sets at twelve o' clock."), "20 8 5 19 21 14 19 5 20 19 5 20 19 1 20 20 23 5 12 22 5 15 3 12 15 3 11")
    assert_equal(alphabet_position("-.-'"), "")
  end
end
