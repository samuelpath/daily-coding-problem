# In this kata you will create a function that takes a list of 
# non-negative integers and strings and returns a new list with the strings filtered out.

# Example
# filter_list([1,2,'a','b']) == [1,2]
# filter_list([1,'a','b',0,15]) == [1,0,15]
# filter_list([1,2,'aasf','1','123',123]) == [1,2,123]

require 'test-unit'

def filter_list(l)
  l.reject { |item| item.class == String }
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(filter_list([1,2,'a','b']),[1,2])
    assert_equal(filter_list([1,'a','b',0,15]),[1,0,15])
    assert_equal(filter_list([1,2,'aasf','1','123',123]),[1,2,123])  end
end
