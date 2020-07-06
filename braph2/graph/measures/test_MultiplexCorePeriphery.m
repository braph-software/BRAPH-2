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
    
known_multiplex_core_periphery = {[0 1 0 0]'};      

g = MultiplexGraphBU(A);
multiplex_core_periphery = MultiplexCorePeriphery(g, 'RichnessThreshold', 1);

assert(isequal(multiplex_core_periphery.getValue(), known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexGraphBU.')

%% Test 2: MultiplexGraphBD
A11 = [
    0  1  1  1; 
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
    0  1  1  0
    ];
A = {
    A11     A12
    A21     A22
    };
        
known_multiplex_core_periphery = {[0 1 0 0]'};     

g = MultiplexGraphBD(A);
multiplex_core_periphery = MultiplexCorePeriphery(g, 'RichnessThreshold', -1, 'MultirichnessCoefficients', [2/3, 1/3]);

assert(isequal(multiplex_core_periphery.getValue(), known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexGraphBD.')

%% Test 3: MultiplexGraphWU
A11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
A = {
    A11     A12
    A21     A22
    };   
   
known_multiplex_core_periphery = {[0 1 0 0]'};    

g = MultiplexGraphWU(A);
multiplex_core_periphery = MultiplexCorePeriphery(g, 'RichnessThreshold', 1, 'MultirichnessCoefficients', [3/4, 1/4]);

assert(isequal(multiplex_core_periphery.getValue(), known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexGraphWU.')

%% Test 4: MultiplexGraphWD
A11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
A12 = eye(4);
A21 = eye(4);
A22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
A = {
    A11     A12
    A21     A22
    };    

known_multiplex_core_periphery = {[0 1 0 0]'};

g = MultiplexGraphWD(A);
multiplex_core_periphery = MultiplexCorePeriphery(g, 'MultirichnessCoefficients', [3/4, 1/4]);

assert(isequal(multiplex_core_periphery.getValue(), known_multiplex_core_periphery), ...
    [BRAPH2.STR ':MultiplexCorePeriphery:' BRAPH2.BUG_ERR], ...
    'MultiplexCorePeriphery is not being calculated correctly for MultiplexGraphWD.')