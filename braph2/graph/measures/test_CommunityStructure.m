% test CommunityStructure

%% Test 1: GraphBU BCT

A = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 0;
    1 0 0 0;
    ];

known_community_structure = [ 2; 1; 1; 2; ] ; % community afiliation vector
g = GraphBU(A);
community_structure = CommunityStructure(g, 'CommunityStructureAlgorithm', 'louvain_bct').getValue();

assert(isequal(community_structure, known_community_structure), ...
    [BRAPH2.STR ':CommunityStructure:' BRAPH2.BUG_ERR], ...
    'CommunityStructure is not being calculated correctly for GraphWD')

%% Test 2: GraphBU General Louvain
A = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 0;
    1 0 0 0;
    ];

known_community_structure = {2;1;1;2};  % community afiliation vector
g = GraphBU(A);
community_structure = CommunityStructure(g, 'CommunityStructureAlgorithm', 'louvain_general').getValue();

assert(isequal(community_structure, known_community_structure), ...
    [BRAPH2.STR ':CommunityStructure:' BRAPH2.BUG_ERR], ...
    'CommunityStructure is not being calculated correctly for GraphWD')
