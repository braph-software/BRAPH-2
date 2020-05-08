function bool = are_compatible(g, m)
% ARE_COMPATIBLE checks whether graph and measure are compatible
%
% B = ARECOMPATIBLE(G, M) checks whether the graph G and the measure M are compatible
%
% See also BINARIZE, DEDIAGONALIZE, SEMIPOSITIVIZE, SYMMETRIZE.

% whether graph and measure are compatible

graph_class = Graph.getClass(g);

compatible_graph_list = Measure.getCompatibleGraphList(m);

bool = any(strcmp(compatible_graph_list, graph_class));

end
