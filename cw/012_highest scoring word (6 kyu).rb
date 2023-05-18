# Given a string of words, you need to find the highest scoring word.
# Each letter of a word scores points according to its position in the alphabet: a = 1, b = 2, c = 3 etc.
# For example, the score of abad is 8 (1 + 2 + 1 + 4).
# You need to return the highest scoring word as a string.
# If two words score the same, return the word that appears earliest in the original string.
# All letters will be lowercase and all inputs will be valid.

require 'test-unit'
require 'pry'

def high(words)
  words_split = words.split
  words_score = words_split.map { |word| word_to_score(word) }
  word_score_mapping = Hash[words_split.zip(words_score)]
  word_score_mapping.max_by { |word, score| score }.first
end

def word_to_score(word)
  word.chars.reduce(0) { |sum, char| sum + char.ord - 96 }
end

class Tests < Test::Unit::TestCase
  def tests
    # assert_equal(high('man i need a taxi up to ubud'), 'taxi')
    assert_equal(high('what time are we climbing up the volcano'), 'volcano')
    assert_equal(high('take me to semynak'), 'semynak')
    assert_equal(high('aa b'), 'aa')
    assert_equal(high('b aa'), 'b')
    assert_equal(high('bb d'), 'bb')
    assert_equal(high('d bb'), 'd') 
    assert_equal(high('aaa b'), 'aaa')
  end
end
