% test MultiplexCorePeriphery

%% Test 1: MultiplexGraphBU
A11 = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    1  1  0  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_core_periphery = {[5 5 4 2]'};      

g = MultiplexGraphBU(A);
multiplex_core_periphery = MultiplexCorePeriphery(g, 'RichnessThreshold', 1);

assert(isequal(multiplex_core_periphery.getValue(), known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexGraphBU.')
