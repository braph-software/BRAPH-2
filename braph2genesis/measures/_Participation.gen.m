%% ¡header!
Participation < Measure (m, participation) is the graph participation.

%%% ¡description!
The participation of a node is the ratio of edges that a node forms within
a single layer community to the total number of edges that forms within the whole single layer graph.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphBU
MultigraphBUD
MultigraphBUT
GraphWD
GraphWU
MultiplexBD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWD
MultiplexWU

%% ¡props!
%%% ¡prop! 
CI (metadata, MATRIX) 
%%%% ¡default!
1

%%% ¡prop! 
rule (metadata, OPTION) 
%%%% ¡settings!
{'in' 'out' }
%%%% ¡default!
'out'

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the participation.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();

participation = cell(L, 1);        
directionality_type =  g.getDirectionalityType(L);
connectivity_type =  g.getConnectivityType(L);
for li = 1:1:L
   connectivity_layer = connectivity_type(li, li);
   directionality_layer = directionality_type(li, li);
    if L == 1 
        S = CommunityStructure('G', g).get('M');
    else
        S = MultilayerCommunityStructure('G', g).get('M');
    end
    Aii = A{li, li};    
    m.set('CI', cell2mat(S));
   
    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            ko = Strength('G', g).get('M');
        else  % directed graphs

            directed_participation_rule = m.get('rule');
            switch lower(directed_participation_rule)
                case {'in'}  % in-degree rule                   
                    ko = InStrength('G', g).get('M');                   
                otherwise  % {'out'}  % out-degree rule
                    ko = OutStrength('G', g).get('M');
            end
        end
    else  % binary graphs
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            ko = Degree('G', g).get('M');
        else  % directed graphs
            
            directed_participation_rule = m.get('rule');
            switch lower(directed_participation_rule)
                case {'in'}  % in-degree rule
                    ko = InDegree('G', g).get('M');
                otherwise  % {'out'}  % out-degree rule
                    ko = OutDegree('G', g).get('M');
            end
        end
    end

    Gc = (Aii~=0)*diag(S{li});  % neighbor community affiliation
    Kc2 = zeros(N(1), 1);  % community-specific neighbors

    for i=1:max(S{li})
        Kc2 = Kc2 + (sum(Aii.*(Gc==i), 2).^2);
    end

    participation_layer = ones(N(1), 1) - Kc2./(ko{li}.^2);
    participation_layer(~ko{li}) = 0;  % participation = 0 if for nodes with no (out)neighbors
    participation(li) = {participation_layer};
end

value = participation;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!

A = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

known_participation = {[0 4/9 3/8 4/9 12/25 0 0 0]'};

g = GraphBU('B', A);
participation = Participation('G', g).get('M');

assert(isequal(participation, known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!

A = [
    0 1 1 1 0 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 1 0 0 0;
    0 0 1 0 1 0 0 0;
    0 0 0 0 0 1 1 0;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 1;
    0 0 0 0 0 0 0 0
    ];

% out rule - default
known_participation_default_out = {[0 1/2 0 1/2 0 0 0 0]'};

g = GraphBD('B', A);
participation = Participation('G', g).get('M');

assert(isequal(participation, known_participation_default_out), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBD.')

% in rule 
known_participation_in = {[0 -1 8/9 -1 5/9 0 0 1]'};

g = GraphBD('B', A);
participation = Participation('G', g, 'rule', 'in').get('M');

assert(isequal(participation, known_participation_in), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!

A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];

A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {A11 A22};
 
known_participation = {
                 [0 0 0 0]'
                 [0 0 0 0]'
                 };   
 
g = MultiplexBU('B', A);
participation = Participation('G', g).get('M');

assert(isequal(participation, known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for MultiplexBU.')

