# Complete the method/function so that it converts dash/underscore delimited words into camel casing.
# The first word within the output should be capitalized only if the original word was capitalized
# (known as Upper Camel Case, also often referred to as Pascal case). The next words should be always capitalized.

# Examples
# "the-stealth-warrior" gets converted to "theStealthWarrior"
# "The_Stealth_Warrior" gets converted to "TheStealthWarrior"
# "The_Stealth-Warrior" gets converted to "TheStealthWarrior"

require 'test-unit'

def to_camel_case(str)
  str
    .gsub(/[_|-](.)/, &:upcase)
    .gsub(/[_|-]/, '')
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(to_camel_case(''), '', "An empty string was provided but not returned")
    assert_equal(to_camel_case("the_stealth_warrior"), "theStealthWarrior", "to_camel_case('the_stealth_warrior') did not return correct value")
    assert_equal(to_camel_case("The-Stealth-Warrior"), "TheStealthWarrior", "to_camel_case('The-Stealth-Warrior') did not return correct value")
    assert_equal(to_camel_case("A-B-C"), "ABC", "to_camel_case('A-B-C') did not return correct value")
  end
end
