require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = {
    source => { cost: 0, last_edge: nil }
  }

  until possible_paths.empty?
    min_vertex = select_shortest_path(possible_paths)
    shortest_paths[min_vertex] = possible_paths[min_vertex]
    possible_paths.delete(min_vertex)

    min_vertex.out_edges.each do |edge|

      if shortest_paths.keys.include?(edge.to_vertex)
        next
      elsif possible_paths.keys.include?(edge.to_vertex)
        old_cost = possible_paths[edge.to_vertex][:cost]
        next if old_cost <= edge.cost + shortest_paths[min_vertex][:cost]
      end
      possible_paths[edge.to_vertex] = { cost: shortest_paths[min_vertex][:cost] + edge.cost,
        last_edge: edge
      }
    end
  end

  shortest_paths
end

def select_shortest_path(paths)
  min_vertex = nil
  paths.each do |key, value|
    if min_vertex.nil? || value[:cost] < paths[min_vertex][:cost]
      min_vertex = key
    end
  end
  min_vertex
end
