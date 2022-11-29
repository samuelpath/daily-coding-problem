require File.expand_path(File.dirname(__FILE__) + '/assert')
require 'pry'
require 'json'

# Level: Medium
# This problem was asked by Google.

# Given the root to a binary tree, implement serialize(root), which serializes the tree into a string,
# and deserialize(s), which deserializes the string back into the tree.
# 
# For example, given the following Node class:
# 
# class Node:
#     def __init__(self, val, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
#
# The following test should pass:
# 
# node = Node('root', Node('left', Node('left.left')), Node('right'))
# assert deserialize(serialize(node)).left.left.val == 'left.left'

# my Ruby implementation of the Node class given in the instructions in Python
class Node
  attr_reader :val, :left, :right

  def initialize(val, left=nil, right=nil)
    @val = val
    @left = left
    @right = right
  end
end

######### SOLUTIONS #########

# I'm serializing to JSON, since that's a binary tree serialized format I know, and I can use the JSON parser for the deserialization
# I'm of course using recursivity, and for such tasks I'm not sure there's any other/better way
def serialize(root)
  "{\"val\": \"#{root.val}\", \"left\": #{ serialize_or_null(root.left) }, \"right\": #{ serialize_or_null(root.right) }}"
end

def serialize_or_null(root)
  root ? serialize(root) : 'null'
end

# I'm using the JSON parser to get an object, which makes the deserialization much easier (no need to parse strings)
# Using the language's built in tools isn't considered cheating here, right?
def deserialize(string)
  json = JSON.parse(string)
  Node.new(json["val"], deserialize_or_nil(json["left"]), deserialize_or_nil(json["right"]))
end

def deserialize_or_nil(root)
  !!root ? deserialize(JSON.dump(root)) : nil
end

######### ASSERTIONS #########

node = Node.new('root', Node.new('left', Node.new('left.left')), Node.new('right'))
assert { deserialize(serialize(node)).left.left.val == 'left.left' }