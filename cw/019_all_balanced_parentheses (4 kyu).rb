# Write a function which makes a list of strings representing all of the ways you can balance n pairs of parentheses

# Examples
# balanced_parens(0) => [""]
# balanced_parens(1) => ["()"]
# balanced_parens(2) => ["()()","(())"]
# balanced_parens(3) => ["()()()","(())()","()(())","(()())","((()))"]

require 'test-unit'
require 'pry'

def balanced_parens(n)
  return [""] if n == 0

  result = []

  balanced_parens(n-1).each do |item|
    result << "()#{item}"
    result << "(#{item})"
    result << "#{item}()"
  end

  result.uniq
end

class Tests < Test::Unit::TestCase
  def tests
    [
        [0, [""]],
        [1, ["()"]],
        [2, ["(())", "()()"]],
        [3, ["((()))","(()())","(())()","()(())", "()()()"]]
    ].each{ |n,exp|
        act = balanced_parens(n).sort!
        assert_equal(act,exp)
    }
  end
end
