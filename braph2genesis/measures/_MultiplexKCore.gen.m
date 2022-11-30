%% ¡header!
MultiplexKCore < Measure (m, multiplex k-core) is the multiplex k-core.

%%% ¡description!
The multiplex k-core of a graph is the largest subnetwork comprising nodes of overlapping degree k or higher. 
k is set by the user; the default value is equal to 1.

%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBD
MultiplexBU
MultiplexWD
MultiplexWU
OrderedMultiplexWU

%% ¡props!
%%% ¡prop! 
MultiplexKCoreThreshold (parameter, SCALAR) is the multiplex k-core threshold
%%%% ¡default!
1

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex k-core.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    A = g.get('A'); % 2D-cell array (for multigraph, multiplex, etc.)
    N = g.nodenumber();
    
    multiplex_kcore_threshold = m.get('MultiplexKCoreThreshold');
    assert(mod(multiplex_kcore_threshold, 1) == 0, ...
        [BRAPH2.STR ':MultiplexKCore:' BRAPH2.WRONG_INPUT], ...
        ['MultiplexKCore threshold must be an integer value ' ...
        'while it is ' tostring(multiplex_kcore_threshold)])
    
    directionality_layer =  g.getDirectionalityType(l);
    multiplex_k_core = cell(length(ls), 1);
    for i = 1:1:length(ls)
        A_sum = zeros(N(1), N(1));
        for j = 1:1:length(l)
            A_sum = A_sum + A{j, j};
        end
        iter = 0;
        subAii = binarize(A_sum);
        while 1
            if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                ovdeg = sum(subAii, 1)';   % ov. degree undirected 
            else
                ovdeg = (sum(subAii, 1)' + sum(subAii, 2));  % ov. degree directed
            end
         
            % find nodes with degree < k
            low_k_nodes = find((ovdeg < multiplex_kcore_threshold) & (ovdeg > 0));

            % if none found -> stop
            if (isempty(low_k_nodes)) break; end; %#ok<SEPEX>

            % peel away found nodes
            iter = iter + 1;
            subAii(low_k_nodes, :) = 0;
            subAii(:, low_k_nodes) = 0;
        end
        multiplex_k_core(i) = {subAii};  % add multiplex k-core 
    end
    value = multiplex_k_core;
end
%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

A22 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A = {A11 A22};
             
known_mkcore = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
                     

g = MultiplexWU('B', A);
mkcore = MultiplexKCore('G', g, 'MultiplexKCoreThreshold', 2).get('M');

assert(isequal(mkcore, known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCore:' BRAPH2.BUG_ERR], ...
    'MultiplexKCore is not being calculated correctly for MultiplexGraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  .5  0
    ];

A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {A11 A22};

known_mkcore = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                0  1  1  0
                ]};            

g = MultiplexWD('B', A);
mkcore = MultiplexKCore('G', g, 'MultiplexKCoreThreshold', 4).get('M');

assert(isequal(mkcore, known_mkcore), ...
    [BRAPH2.STR ':MultiplexKCore:' BRAPH2.BUG_ERR], ...
    'MultiplexKCore is not being calculated correctly for MultiplexGraphWD.')