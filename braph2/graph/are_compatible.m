function bool = are_compatible(g, m)
% ARE_COMPATIBLE checks whether graph and measure are compatible
%
% BOOL = ARE_COMPATIBLE(GRAPh, MEASURE) checks whether the graph GRAPH and
% the measure MEASURE are compatible. 
%
% See also GRAPH, MEASURE.

graph_class = Graph.getClass(g);

compatible_graph_list = Measure.getCompatibleGraphList(m);

bool = any(strcmp(compatible_graph_list, graph_class));

end
