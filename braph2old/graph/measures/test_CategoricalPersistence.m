% test CategoricalPersistence

%% Test 1: MultiplexGraphBU
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {
    A11     A12
    A21     A22
    };
 
known_categorical_persistence = {1};   
 
g = MultiplexGraphBU(A);
categorical_persistence = CategoricalPersistence(g);

assert(isequal(categorical_persistence.getValue(), known_categorical_persistence), ...
    [BRAPH2.STR ':CategoricalPersistence:' BRAPH2.BUG_ERR], ...
    'CategoricalPersistence is not being calculated correctly for MultiplexGraphBU.')

%% Test 2: MultiplexGraphBD
A11 = [
      0 1 1 0;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0 1 1 0;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {
    A11     A12
    A21     A22
    };
 
known_categorical_persistence = {1};   
 
g = MultiplexGraphBD(A);
categorical_persistence = CategoricalPersistence(g);

assert(isequal(categorical_persistence.getValue(), known_categorical_persistence), ...
    [BRAPH2.STR ':CategoricalPersistence:' BRAPH2.BUG_ERR], ...
    'CategoricalPersistence is not being calculated correctly for MultiplexGraphBD.')

%% Test 1: MultiplexGraphWU
A11 = [
      0  1 1 .1;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0  1 1 .1;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A = {
    A11     A12
    A21     A22
    };
 
known_categorical_persistence = {1};   
 
g = MultiplexGraphWU(A);
categorical_persistence = CategoricalPersistence(g);

assert(isequal(categorical_persistence.getValue(), known_categorical_persistence), ...
    [BRAPH2.STR ':CategoricalPersistence:' BRAPH2.BUG_ERR], ...
    'CategoricalPersistence is not being calculated correctly for MultiplexGraphWU.')

%% Test 1: MultiplexGraphWD
A11 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0  1 1 .5;
      1  0 1 0;
      1  1 0 1;
      .1 0 1 0
      ];
A = {
    A11     A12
    A21     A22
    };
 
known_categorical_persistence = {1};   
 
g = MultiplexGraphWD(A);
categorical_persistence = CategoricalPersistence(g);

assert(isequal(categorical_persistence.getValue(), known_categorical_persistence), ...
    [BRAPH2.STR ':CategoricalPersistence:' BRAPH2.BUG_ERR], ...
    'CategoricalPersistence is not being calculated correctly for MultiplexGraphWD.')
