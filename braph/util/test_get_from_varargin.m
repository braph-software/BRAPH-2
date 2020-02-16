% test get_from_varargin

%% Test 1: Empty
value = 0;
handle = 'Value';
varagin = {};
assert(isequal(get_from_varargin(value, handle, varagin{:}), value), ...
    'BRAPH:value:get_from_varargin:Bug', ...
    'Error with empty varargin.')

%% Test 2: Full
value = 0;
handle = 'Value';
varagin = {'Handle2', 'none', 'Value', 1, 'Handle 3', 'none'};
assert(isequal(get_from_varargin(value, handle, varagin{:}), 1), ...
    'BRAPH:value:get_from_varargin:Bug', ...
    'Error with empty varargin.')