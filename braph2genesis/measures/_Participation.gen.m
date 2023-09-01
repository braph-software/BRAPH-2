%% ¡header!
Participation < Measure (m, participation) is the graph participation.

%%% ¡description!
The participation of a node is the ratio of edges that a node forms within 
<<<<<<< Updated upstream
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
CI (parameter, MATRIX) 
%%%% ¡default!
1

%%% ¡prop! 
rule (parameter, OPTION) 
%%%% ¡settings!
{'in' 'out' }
%%%% ¡default!
'out'
=======
 a single layer community to the total number of edges that forms within the whole single layer graph.
>>>>>>> Stashed changes

%% ¡props_update!

%%% ¡prop!
<<<<<<< Updated upstream
=======
NAME (constant, string) is the name of the participation.
%%%% ¡default!
'Participation'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the participation.
%%%% ¡default!
'The participation of a node is the ratio of edges that a node forms within a single layer community to the total number of edges that forms within the whole single layer graph.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the participation.
%%%% ¡settings!
'Participation'

%%% ¡prop!
ID (data, string) is a few-letter code of the participation.
%%%% ¡default!
'Participation ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the participation.
%%%% ¡default!
'Participation label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the participation.
%%%% ¡default!
'Participation notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphBD' 'GraphBU' 'MultigraphBUT''MultiplexBU' } ;%TBE % % % add any missing tests

%%% ¡prop!
>>>>>>> Stashed changes
M (result, cell) is the participation.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
<<<<<<< Updated upstream
[l, ls] = g.layernumber();
N = g.nodenumber();

participation = cell(l, 1);        
directionality_type =  g.getDirectionalityType(l);
connectivity_type =  g.getConnectivityType(l);
if ls(1) == 1
=======
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');
ls = g.get('PARTITIONS');
directed_participation_rule = m.get('RULE');
participation = cell(L, 1);
directionality_type =   g.get('DIRECTIONALITY_TYPE', L);
connectivity_type =  g.get('CONNECTIVITY_TYPE', L);
if ls == 1
>>>>>>> Stashed changes
    S = CommunityStructure('G', g).get('M');
else
    S = MultilayerCommunityStructure('G', g).get('M');
end
    
<<<<<<< Updated upstream
for li = 1:1:l
=======
for li = 1:1:L
>>>>>>> Stashed changes
    connectivity_layer = connectivity_type(li, li);
    directionality_layer = directionality_type(li, li);
    Aii = A{li, li};
    m.set('CI', cell2mat(S));
   
    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            ko = Strength('G', g).get('M');
        else  % directed graphs
<<<<<<< Updated upstream

            directed_participation_rule = m.get('rule');
=======
>>>>>>> Stashed changes
            switch lower(directed_participation_rule)
                case {'in'}  % in-strength rule                   
                    ko = InStrength('G', g).get('M');                   
                otherwise  % {'out'}  % out-strength rule
                    ko = OutStrength('G', g).get('M');
            end
        end
    else  % binary graphs
        if directionality_layer == Graph.UNDIRECTED  % undirected graphs
            ko = Degree('G', g).get('M');
        else  % directed graphs
<<<<<<< Updated upstream
            
            directed_participation_rule = m.get('rule');
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream

value = participation;

%% ¡tests!

=======
value = participation;

%% ¡props!

%%% ¡prop! 
RULE (parameter, option)
%%%% ¡settings!
{'in' 'out'}
%%%% ¡default!
'out'

%% ¡tests!

%%% ¡excluded_props!
[Participation.PFM]


>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
participation = Participation('G', g).get('M');

assert(isequal(participation, known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBU.')
=======

m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
>>>>>>> Stashed changes

%%% ¡test!
%%%% ¡name!
MultigraphBUT
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

known_participation = {...
    [0 4/9 3/8 4/9 12/25 0 0 0]'
    [0 0   0   0   0     0 0 0]'};

g = MultigraphBUT('B', A, 'THRESHOLDS', [0 1]);
<<<<<<< Updated upstream
participation = Participation('G', g).get('M');

assert(isequal(participation, known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for MultigraphBUT.')
=======

m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
participation = Participation('G', g).get('M');

assert(isequal(participation, known_participation_default_out), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBD.')
=======

m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
>>>>>>> Stashed changes

% in rule 
known_participation_in = {[0 -1 8/9 -1 5/9 0 0 1]'};

g = GraphBD('B', A);
<<<<<<< Updated upstream
participation = Participation('G', g, 'rule', 'in').get('M');

assert(isequal(participation, known_participation_in), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for GraphBD.')
=======
m_outside_g = Participation('G', g);
m_outside_g.set('RULE', 'in');
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
m_inside_g.set('RULE', 'in');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
participation = Participation('G', g).get('M');

assert(isequal(participation, known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.BUG_ERR], ...
    'Participation is not being calculated correctly for MultiplexBU.')

=======
m_outside_g = Participation('G', g);
assert(isequal(m_outside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Participation');
assert(isequal(m_inside_g.get('M'), known_participation), ...
    [BRAPH2.STR ':Participation:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
>>>>>>> Stashed changes
