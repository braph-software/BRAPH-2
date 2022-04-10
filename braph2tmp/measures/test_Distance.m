%TEST_DISTANCE

%% Test 1.1: Instantiation - empty

m = Distance();

prop_number = Distance.getPropNumber();
for prop = 1:1:prop_number
	TAG = upper(Distance.getPropTag(prop));
	assert( ...
		isa(m.getr(prop), 'NoValue'), ...
		[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
		['Distance.getr(' int2str(prop) ') must be inizialized to NoValue(). ' ...
		'Or there could be an error in Distance.getr(' int2str(prop) ').'] ...
		)
	assert( ...
		isa(m.getr(TAG), 'NoValue'), ...
		[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
		['Distance.getr(''' TAG ''') must be inizialized to NoValue(). ' ...
		'Or there could be an error in Distance.getr(''' TAG ''').'] ...
		)
end

%% Test 1.2: Instantiation - defaults

warning('off', 'BRAPH2:Distance')
m = Distance( ...
	Distance.ID, Distance.getPropDefault(Distance.ID), ...
	Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
	Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
	Distance.G, Distance.getPropDefault(Distance.G), ...
	Distance.M, Distance.getPropDefault(Distance.M) ...
	);
warning('on', 'BRAPH2:Distance')

for prop = 1:1:Distance.getPropNumber()
	TAG = upper(Distance.getPropTag(prop));
	switch Distance.getPropCategory(prop)
		case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
			assert( ...
				isequal(m.getr(prop), Distance.getPropDefaultConditioned(prop)), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must be inizialized to its default value ' ...
				'given by Distance.getPropDefaultConditioned(' int2str(prop) '). ' ...
				'Or there could be an error in Distance.getr(' int2str(prop) ').'] ...
				)
			assert( ...
				isequal(m.getr(TAG), Distance.getPropDefaultConditioned(prop)), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(''' TAG ''') must be inizialized to its default value ' ...
				'given by Distance.getPropDefaultConditioned(' int2str(prop) '). ' ...
				'Or there could be an error in Distance.getr(''' TAG ''').'] ...
				)
		case Category.RESULT
			assert( ...
				isa(m.getr(prop), 'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Being a result, Distance.getr(' int2str(prop) ') must be inizialized to NoValue(). ' ...
				'Or there could be an error in Distance.getr(' int2str(prop) ').'] ...
				)
			assert( ...
				isa(m.getr(TAG), 'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Being a result, Distance.getr(''' TAG ''') must be inizialized to NoValue(). ' ...
				'Or there could be an error in Distance.getr(''' TAG ''').'] ...
				)
	end
end

%% Test 2: Callbacks

warning('off', 'BRAPH2:Distance')
m_0 = Distance( ...
	Distance.ID, Distance.getPropDefault(Distance.ID), ...
	Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
	Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
	Distance.G, Distance.getPropDefault(Distance.G), ...
	Distance.M, Distance.getPropDefault(Distance.M) ...
	);
warning('on', 'BRAPH2:Distance')

m_1 = Distance( ...
	Distance.ID, Callback('EL', m_0, 'PROP', 1), ...
	Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
	Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
	Distance.G, Callback('EL', m_0, 'PROP', 4), ...
	Distance.M, NoValue() ...
	);
	
prop_number = Distance.getPropNumber();
for prop = 1:1:prop_number
	TAG = upper(Distance.getPropTag(prop));
	switch Distance.getPropCategory(prop)
		case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
			assert( ...
				isa(m_1.getr(prop),  'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must be a callback.'] ...
				)
			assert( ...
				isequal(m_1.get(prop), m_0.get(prop)) && ~isa(m_1.get(prop), 'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.get(' int2str(prop) ') must be the actual property and NOT a callback.'] ...
				)
		case {Category.METADATA, Category.RESULT}
			assert( ...
				~isa(m_1.getr(prop), 'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must NOT be a callback.'] ...
				)
	end
end
m_2 = Distance( ...
	Distance.ID, Callback('EL', m_1, 'PROP', 1), ...
	Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
	Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
	Distance.G, Callback('EL', m_1, 'PROP', 4), ...
	Distance.M, NoValue() ...
	);
	
prop_number = Distance.getPropNumber();
for prop = 1:1:prop_number
	TAG = upper(Distance.getPropTag(prop));
	switch Distance.getPropCategory(prop)
		case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
			assert( ...
				isa(m_2.getr(prop),  'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must be a callback.'] ...
				)
			assert( ...
				isequal(m_2.get(prop), m_0.get(prop)) && ~isa(m_1.get(prop), 'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.get(' int2str(prop) ') must be the actual property and NOT a callback.'] ...
				)
		case {Category.METADATA, Category.RESULT}
			assert( ...
				~isa(m_2.getr(prop), 'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must NOT be a callback.'] ...
				)
	end
end
m_3 = Distance( ...
	Distance.ID, Callback('EL', m_2, 'PROP', 1), ...
	Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
	Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
	Distance.G, Callback('EL', m_2, 'PROP', 4), ...
	Distance.M, NoValue() ...
	);
	
prop_number = Distance.getPropNumber();
for prop = 1:1:prop_number
	TAG = upper(Distance.getPropTag(prop));
	switch Distance.getPropCategory(prop)
		case {Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
			assert( ...
				isa(m_3.getr(prop),  'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must be a callback.'] ...
				)
			assert( ...
				isequal(m_3.get(prop), m_0.get(prop)) && ~isa(m_1.get(prop), 'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.get(' int2str(prop) ') must be the actual property and NOT a callback.'] ...
				)
		case {Category.METADATA, Category.RESULT}
			assert( ...
				~isa(m_3.getr(prop), 'Callback'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must NOT be a callback.'] ...
				)
	end
end

%% Test 3: Result

warning('off', 'BRAPH2:Distance')
m = Distance( ...
	Distance.ID, Distance.getPropDefault(Distance.ID), ...
	Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
	Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
	Distance.G, Distance.getPropDefault(Distance.G), ...
	Distance.M, Distance.getPropDefault(Distance.M) ...
	);
warning('on', 'BRAPH2:Distance')

prop_number = Distance.getPropNumber();
for prop = 1:1:prop_number
	TAG = upper(Distance.getPropTag(prop));
	switch Distance.getPropCategory(prop)
		case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
		case Category.RESULT
			assert( ...
				~isa(m.get(prop),  'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.get(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
				)
			assert( ...
				isa(m.getr(prop),  'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must be a NoValue, because it has not been memorized.'] ...
				)
			if isempty(m.getPropSettings(prop))
				assert( ...
					m.checkFormat(m.getPropFormat(prop), m.get(prop)), ...
					[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
					['Distance.get(' int2str(prop) ') returns a value with the wrong format.'] ...
					)
			else
				assert( ...
					m.checkFormat(m.getPropFormat(prop), m.get(prop), m.getPropSettings(prop)), ...
					[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
					['Distance.get(' int2str(prop) ') returns a value with the wrong format.'] ...
					)
			end
	end
end

%% Test 4: Memorize

warning('off', 'BRAPH2:Distance')
m = Distance( ...
	Distance.ID, Distance.getPropDefault(Distance.ID), ...
	Distance.LABEL, Distance.getPropDefault(Distance.LABEL), ...
	Distance.NOTES, Distance.getPropDefault(Distance.NOTES), ...
	Distance.G, Distance.getPropDefault(Distance.G), ...
	Distance.M, Distance.getPropDefault(Distance.M) ...
	);
warning('on', 'BRAPH2:Distance')

for prop = 1:1:Distance.getPropNumber()
	TAG = upper(Distance.getPropTag(prop));
	switch Distance.getPropCategory(prop)
		case {Category.METADATA, Category.PARAMETER, Category.DATA, Category.FIGURE, Category.GUI}
		case Category.RESULT
			assert( ...
				~isa(m.get(prop),  'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.get(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
				)
			assert( ...
				isa(m.getr(prop),  'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must be a NoValue, because it should NOT have been memorized.'] ...
				)
			assert( ...
				~isa(m.memorize(prop),  'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.memorize(' int2str(prop) ') must NOT be a NoValue, because it should have been calculated.'] ...
				)
			assert( ...
				~isa(m.getr(prop),  'NoValue'), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') must NOT be a NoValue, because it should have been memorized.'] ...
				)
			assert( ...
				m.checkFormat(m.getPropFormat(prop), m.getr(prop),m.getPropSettings(prop)), ...
				[BRAPH2.STR ':Distance:' BRAPH2.BUG_FUNC], ...
				['Distance.getr(' int2str(prop) ') returns a value with the wrong format.'] ...
				)
	end
end

%% Test 5: GraphBU

B = [
    0	1   1	1   0
    1   0   0   1   0
    1   0   0   1   0
    1   1   1   0   0
    0	0	0   0   0
    ];

known_distance = {[
    0   1   1   1   Inf
    1   0   2   1   Inf
    1   2   0   1   Inf
    1   1   1   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphBU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBU.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBU.')

%% Test 6: GraphBD

B = [
    0   1	1   1   0
    1	0   0   0   0
    1   1   0   1   0
    1   1   0   0   0
    0	0   0   0   0
    ];

known_distance = {[
    0   1   1   1   Inf
    1   0   2   2   Inf
    1   1   0   1   Inf
    1   1   2   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphBD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBD.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBD.')

%% Test 7: GraphWU

B = [
    0     .1    .2  .25  0
    .125  0     0   0    0
    .2    .5    0   .25  0
    .125  10    0   0    0
    0     0     0   0    0
    ];

known_distance = {[
    0   5   5   4   Inf
    5   0   2   1   Inf
    5   2   0   3   Inf
    4   1   3   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphWU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWU.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWU.')

%% Test 8: GraphWD

B = [
    0     .1  .2  .25  0
    .125  0   0   0    0
    .2    .5  0   .25  0
    .125  10   0   0   0
    0     0   0   0    0
    ];

known_distance = {[
    0   5   5   4   Inf
    8   0   13  12  Inf
    5   2   0   4   Inf
    8   1   13  0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphWD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWD.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWD.')

%% Test 9: MultigraphBUT

B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_distance = {
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUT.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUT.')

%% Test 10: MultigraphBUD

B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUD.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUD.')

%% Test 11: MultiplexBU
B11 = [
    0	1   1  0    0;
    1   0   0  0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0   1   1   1   0; 
    1   0   0   0   0;
    1   1   0   1   0;
    1   1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexBU('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexBU.')



%% Test 12: MultiplexBD
B11 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};
known_distance = {
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexBD('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexBD.')



%% Test 13: MultiplexWU
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    };

g = MultiplexWU('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexWU.')



%% Test 14: MultiplexWD
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexWD('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexWD.')



