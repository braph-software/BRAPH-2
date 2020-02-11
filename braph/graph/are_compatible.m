function bool = are_compatible(g, m)
% whether measure and graph are compatible

if isa(g, 'Graph')
    graph_code = g.getGraphCode();
else % g should be a string with the graph code
    graph_code = g;
end

compatible_graph_list = {};
if isa(m, 'Measure')
    compatible_graph_list = m.compatible_graph_list();
else % m should be a string with the measure code
    eval(['compatible_graph_list = ' m '.compatible_graph_list();'])
end

bool = any(strcmp(compatible_graph_list, graph_code));
end
