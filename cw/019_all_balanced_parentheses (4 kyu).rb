# Write a function which makes a list of strings representing all of the ways you can balance n pairs of parentheses

# Examples
# balanced_parens(0) => [""]
# balanced_parens(1) => ["()"]
# balanced_parens(2) => ["()()","(())"]
# balanced_parens(3) => ["()()()","(())()","()(())","(()())","((()))"]

require 'test-unit'
require 'pry'
require 'pry-nav'

def balanced_parens(n)
  res = [[""]]

  (1..2*n).each do |step|
    res[step] = []

    res[step-1].each do |prev_compute|
      open_parens = prev_compute.count("(")
      closed_parens = prev_compute.count(")")
      
      action = if open_parens == closed_parens
        :open
      else
        if open_parens == n || step == 2*n
          :close
        else
          :both
        end
      end

      closed = prev_compute + ")"
      opened = prev_compute + "("
      
      if action == :open
        res[step] << opened
      elsif action == :close
        res[step] << closed
      elsif action == :both
        res[step] << opened
        res[step] << closed
      end
    end
  end

  res.last
end

class Tests < Test::Unit::TestCase
  def tests
    [
        [0, [""]],
        [1, ["()"]],
        [2, ["(())", "()()"]],
        [3, ["((()))","(()())","(())()","()(())", "()()()"]],
        [4, ["(((())))", "((()()))", "((())())", "((()))()", "(()(()))", "(()()())", "(()())()", "(())(())", "(())()()", "()((()))", "()(()())", "()(())()", "()()(())", "()()()()"]]
    ].each{ |n,exp|
        act = balanced_parens(n).sort!
        assert_equal(act,exp)
    }
  end
end
