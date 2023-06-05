# In this kata we want to convert a string into an integer. The strings simply represent the numbers in words.

# Examples:

# "one" => 1
# "twenty" => 20
# "two hundred forty-six" => 246
# "seven hundred eighty-three thousand nine hundred and nineteen" => 783919
# Additional Notes:

# The minimum number is "zero" (inclusively)
# The maximum number, which must be supported is 1 million (inclusively)
# The "and" in e.g. "one hundred and twenty-four" is optional, in some cases it's present and in others it's not
# All tested numbers are valid, you don't need to validate them

require 'test-unit'
require 'pry'

def parse_int(str)
  length = str.length
  
  return 'zero' if length == 0
  return 'one million' if length == 7
  
  thousands = length > 3 ? str[0..(length - 4)] : nil
  up_to_999 = str[([0, (length - 3)].max)..]
  
  result = ''
  
  if !thousands.nil?
    result += "#{parse_int_up_from_1_to_999(thousands)} thousand "
  end
  
  result += "#{parse_int_up_from_1_to_999(up_to_999)}"
  
  result
end

def parse_int_up_from_1_to_999(str)
  result = ''
  
  if str.length == 3
    result += "#{parse_int_up_from_1_to_9(str[0])} hundred "
  end
  
  result += parse_int_up_from_1_to_99(str[-2..])
end

def parse_int_up_from_1_to_99(str)
  if str.to_i < 10
    parse_int_up_from_1_to_9(str.to_i.to_s)
  elsif str.to < 20
    parse_int_from_10_to_19(str)
  else
    parse_int_from_20_to_99(str)
  end
end

def parse_int_up_from_1_to_9(str)
  case str
  when '1'
    'one'
  when '2'
    'two'
  when '3'
    'three'
  when '4'
    'four'
  when '5'
    'five'
  when '6'
    'six'
  when '7'
    'seven'
  when '8'
    'eight'
  when '9'
    'nine'
  end
end

def parse_int_from_10_to_19(str)
  case str
  when '10'
    'ten'
  when '11'
    'eleven'
  when '12'
    'twelve'
  when '13'
    'thirteen'
  when '14'
    'fourteen'
  when '15'
    'fifteen'
  when '16'
    'sixteen'
  when '17'
    'seventeen'
  when '18'
    'eighteen'
  when '19'
    'nineteen'
  end
end

def parse_int_from_20_to_99(str)
  "#{parse_tens_from_20_to_90(str[0])}-#{parse_int_up_from_1_to_9(str[1])}"
end

def parse_tens_from_20_to_90(str)
  case str
  when '2'
    'twenty'
  when '3'
    'thirty'
  when '4'
    'forty'
  when '5'
    'fifty'
  when '6'
    'sixty'
  when '7'
    'seventy'
  when '8'
    'eighty'
  when '9'
    'ninety'
  end
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(parse_int('one'), 1)
    assert_equal(parse_int('twenty'), 20)
    assert_equal(parse_int('two hundred forty-six'), 246)
  end
end
