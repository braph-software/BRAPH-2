%% ¡header!
Triangles < Measure (m, triangles) is the graph triangles.

%%% ¡description!
The triangles are calculated as the number of neighbors of a node that are 
also neighbors of each other within a layer. In weighted graphs, the triangles are 
calculated as geometric mean of the weights of the edges forming the triangle.

%%% ¡seealso!
Measure

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWD
GraphBU
MultigraphBUD
MultigraphBUT
GraphBD
MultiplexWU
MultiplexWD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexBD

%% ¡props!

%%% ¡prop! 
rule (parameter, OPTION) is the rule to determine what is a triangle in directed networks.
%%%% ¡settings!
{'all' 'middleman' 'in' 'out' 'cycle'}
%%%% ¡default!
'cycle'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the triangles.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.) 
L = g.layernumber();

triangles = cell(g.layernumber(), 1);
            
directionality_type =  g.getDirectionalityType(g.layernumber());
parfor li = 1:1:L        
    Aii = A{li, li};    
    
    if directionality_type == Graph.UNDIRECTED  % undirected graphs
        triangles_layer = diag((Aii.^(1/3))^3) / 2;
        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
        triangles(li) = {triangles_layer};
        
    else  % directed graphs
        directed_triangles_rule = m.get('rule');
        switch lower(directed_triangles_rule)
            case 'all'  % all rule
                triangles_layer = diag((Aii.^(1/3) + transpose(Aii).^(1/3))^3) / 2;
            case 'middleman'  % middleman rule
                triangles_layer = diag(Aii.^(1/3) * transpose(Aii).^(1/3) * Aii.^(1/3));
            case 'in'  % in rule
                triangles_layer = diag(transpose(Aii).^(1/3) * (Aii.^(1/3))^2);
            case 'out'  % out rule
                triangles_layer = diag((Aii.^(1/3))^2 * transpose(Aii).^(1/3));
            otherwise  % {'cycle'}  % cycle rule
                triangles_layer = diag((Aii.^(1/3))^3);
        end
        triangles_layer(isnan(triangles_layer)) = 0;  % Should return zeros, not NaN
        triangles(li) = {triangles_layer};
    end
end
value = triangles;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0
    ];

known_triangles = {[2 1 2 1]'};

g = GraphBU('B', B);
triangles = Triangles('G', g);

assert(isequal(triangles.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0
    ];

thresholds = [0 1];

known_triangles = { ...
    [2 1 2 1]'
    [0 0 0 0]'
    };


g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);
triangles = Triangles('G', g);

assert(isequal(triangles.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for MultigraphBUT.')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];

% cycle rule - default
known_triangles_default_cycle = {[1 1 1]'};

g = GraphBD('B', B);
triangles = Triangles('G', g);

assert(isequal(triangles.get('M'), known_triangles_default_cycle), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% in rule 
B = [
    0 1 0; 
    0 0 0; 
    1 1 0 
    ];
known_triangles_in = {[0 1 0]'};

g = GraphBD('B', B);
triangles = Triangles('G', g, 'rule', 'in');

assert(isequal(triangles.get('M'), known_triangles_in), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% out rule 
B = [
    0 1 0; 
    0 0 0; 
    1 1 0 
    ];
known_triangles_out = {[0 0 1]'};

g = GraphBD('B', B);
triangles = Triangles('G', g, 'rule',  'out');

assert(isequal(triangles.get('M'), known_triangles_out), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% middleman rule

known_triangles_middleman = {[1 0 0]'};
B = [
    0 1 0; 
    0 0 0; 
    1 1 0 
    ];
g = GraphBD('B', B);
triangles = Triangles('G', g, 'rule', 'middleman');

assert(isequal(triangles.get('M'), known_triangles_middleman), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% all rule 
B = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
known_triangles_all = {[1 1 1]'};

g = GraphBD('B', B);
triangles = Triangles('G', g, 'rule',  'all');

assert(isequal(triangles.get('M'), known_triangles_all), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B = {B11 B22};

known_triangles = {
                 [2 1 2 1]'
                 [2 1 2 1]'
                 };      

g = MultiplexBU('B', B);
triangles = Triangles('G', g);

assert(isequal(triangles.get('M'), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for MultiplexBU.')
