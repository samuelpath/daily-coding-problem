

require 'test-unit'



class Tests < Test::Unit::TestCase
  def tests
    assert_equal(method_call(foo),bar)
  end
end
