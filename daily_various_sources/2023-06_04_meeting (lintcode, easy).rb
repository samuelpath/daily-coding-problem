# https://www.lintcode.com/problem/920/

# Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei),
# determine if a person could attend all meetings.

# (0,8),(8,10) is not conflict at 8

# Example1

# Input: intervals = [(0,30),(5,10),(15,20)]
# Output: false
# Explanation: 
# (0,30), (5,10) and (0,30),(15,20) will conflict

# Example2

# Input: intervals = [(5,8),(9,15)]
# Output: true
# Explanation: 
# Two times will not conflict

require 'test-unit'
require 'pry'

# Definition of Interval:
class Interval
    attr_accessor :start, :end
    def initialize(_start=0, _end=0)
        @start, @end = _start, _end
    end
end

def can_attend_meetings(intervals)
    sorted = intervals.sort_by { |interval| interval.start }
    sorted.each_cons(2) do |pair|
      return false if pair[0].end > pair[1].start
    end
    true
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(can_attend_meetings([Interval.new(0,30),Interval.new(5,10),Interval.new(15,20)]),false)
  end
end
