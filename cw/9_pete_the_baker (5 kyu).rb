# Pete likes to bake some cakes. He has some recipes and ingredients.
# Unfortunately he is not good in maths.
# Can you help him to find out, how many cakes he could bake considering his recipes?

# Write a function cakes(), which takes the recipe (object) and the available ingredients (also an object) 
# and returns the maximum number of cakes Pete can bake (integer).
# For simplicity there are no units for the amounts (e.g. 1 lb of flour or 200 g of sugar are simply 1 or 200).
# Ingredients that are not present in the objects, can be considered as 0.

# Examples:

# // must return 2
# cakes({flour: 500, sugar: 200, eggs: 1}, {flour: 1200, sugar: 1200, eggs: 5, milk: 200}); 
# // must return 0
# cakes({apples: 3, flour: 300, sugar: 150, milk: 100, oil: 100}, {sugar: 500, flour: 2000, milk: 2000});

require 'test-unit'

def cakes(recipe, available)
  cake_max = Float::INFINITY
  recipe.each do |key, value|
    cake_max = [((available[key] || 0) / value).floor, cake_max].min
  end
  cake_max
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(cakes({"flour"=>500, "sugar"=>200, "eggs"=>1},{"flour"=>1200, "sugar"=>1200, "eggs"=>5, "milk"=>200}), 2,"basic_recipes")
    assert_equal(cakes({"cream"=>200, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>1700, "flour"=>20000, "milk"=>20000, "oil"=>30000, "cream"=>5000}),11,"basic_recipes")
    assert_equal(cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000}),0,"missing_ingredient")
    assert_equal(cakes({"apples"=>3, "flour"=>300, "sugar"=>150, "milk"=>100, "oil"=>100},{"sugar"=>500, "flour"=>2000, "milk"=>2000, "apples"=>15, "oil"=>20}),0,"not_enough_ingredients")
    assert_equal(cakes({"eggs"=>4, "flour"=>400},{}),0,"no_ingredients_available")
    assert_equal(cakes({"cream"=>1, "flour"=>3, "sugar"=>1, "milk"=>1, "oil"=>1, "eggs"=>1},{"sugar"=>1, "eggs"=>1, "flour"=>3, "cream"=>1, "oil"=>1, "milk"=>1}),1,"exactly_enough_ingredients_for_1_cake")
  end
end
