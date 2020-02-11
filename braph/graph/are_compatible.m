function bool = are_compatible(g, m)
% whether graph and measure are compatible

graph_class = Graph.getClass(g);

compatible_graph_list = Measure.getCompatibleGraphList(m);

bool = any(strcmp(compatible_graph_list, graph_class));

end
