# https://www.hackerrank.com/challenges/bfsshortreach/problem

# Complete the 'bfs' function below.
#
# The function is expected to return an INTEGER_ARRAY.
# The function accepts following parameters:
#  1. INTEGER n (the number of nodes)
#  2. INTEGER m (the number of edges)
#  3. 2D_INTEGER_ARRAY edges (edges[m][2]: start and end nodes for edges)
#  4. INTEGER s (the node to start traversals from)

require 'test-unit'

EDGE_DISTANCE = 6

def bfs(n, m, edges, s)
  graph = build_graph(n, edges)
  shortest_distance_from_start = get_shortest_distance_from_start(graph, s)

  results = []
  1.upto(n).select { |node| node != s }.each do |node|
    results << shortest_distance_from_start.fetch(node, -1)
  end
  results
end

def build_graph(n, edges)
  graph = {}
  1.upto(n) { |i| graph[i] = [] }
  
  edges.each do |edge|
    graph[edge.first] << edge.last
    graph[edge.last] << edge.first
  end
  graph
end

def get_shortest_distance_from_start(graph, s)
  results_hash = { s => 0 }
  queue = [[s, 0]]

  loop do
    current, distance = queue.shift

    graph[current].each do |node|
      if results_hash[node].nil?
        queue << [node, distance + EDGE_DISTANCE]
        results_hash[node] = distance + EDGE_DISTANCE
      end
    end

    break if queue.empty?
  end
  results_hash
end

class Tests < Test::Unit::TestCase
  def tests
    assert_equal(bfs(5, 3, [[1,2], [1,3], [3,4]], 1), [6, 6, 12, -1])
    assert_equal(bfs(4, 2, [[1,2], [1,3]], 1), [6, 6, -1])
    assert_equal(bfs(3, 1, [[2,3]], 2), [-1, 6])
  end
end
