# Let P be the center of a unit circle. A goat 🐐 is tethered at point Q on the circumference.
# How long does the rope r need to be to allow the goat to graze on exactly one half of the circle's area
# (brown area in diagram, in plane geometry, called a lens)?
# Instructions with diagram and hints: https://gist.github.com/scorphus/a3a79a6b8cbdd413204e823f656f8e14

# YouTube explanation of the math part: https://www.youtube.com/watch?v=ZdQFN2XKeKI

require 'pry'
require 'pry-nav'

PRECISION = 0.000000000000001

def goat_problem
  mini_angle = 0.0
  max_angle = 180.0
  
  angle_in_degrees = max_angle/2
  area = area(angle_in_degrees)
  diff = Math::PI/2 - area
  while (diff.abs > PRECISION)
    if diff < 0
      mini_angle = angle_in_degrees
      angle_in_degrees = (angle_in_degrees + max_angle) / 2
    else
      max_angle = angle_in_degrees
      angle_in_degrees = (angle_in_degrees + mini_angle) / 2
    end
    area = area(angle_in_degrees)
    diff = Math::PI/2 - area
  end
  angle_in_degrees
end

def degrees_to_radians(degrees)
  degrees * (Math::PI / 180.0)
end

def area(angle_in_degrees)
  angle_in_radians = degrees_to_radians(angle_in_degrees)
  Math::PI + angle_in_radians * Math.cos(angle_in_radians) - Math.sin(angle_in_radians)
end

puts goat_problem
