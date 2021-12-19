%TEST_COPY_VARARGIN

%% Test 1: Basic functionality
varargin = {1, 2, 3, 'Four', 'Five'};
varargin_copy = copy_varargin(varargin{:});

for i = 1:1:length(varargin)
    assert(isequal(varargin(i), varargin_copy(i)), ...
        [BRAPH2.STR ':copy_varargin:' BRAPH2.BUG_FUNC], ...
        'Element not copied correctly by copy_varargin().')
end

%% Test 2: Shallow copy objects
obj = DummyObject('shallow copy');
varargin = {obj, 1, 2, 3, 'Four', 'Five'};
varargin_copy = copy_varargin(varargin);
obj_copy = varargin_copy{1};  % should NOT make a deep copy of the obj
 
assert(isequal(obj.name, 'shallow copy') && ...
    isequal(obj_copy.name, 'shallow copy'), ...
	[BRAPH2.STR ':copy_varargin:' BRAPH2.BUG_FUNC], ...
	'Shallow-copy object not copied correctly by copy_varargin().')

obj.name = 'changed name';

assert(isequal(obj.name, 'changed name') && ...
    isequal(obj_copy.name, 'changed name'), ...
	[BRAPH2.STR ':copy_varargin:' BRAPH2.BUG_FUNC], ...
	'Shallow-copy object not copied correctly by copy_varargin().')

%% Test 3: Deep copy objects
obj = DummyCopiableObject('deep copy');
varargin = {obj, 1, 2, 3, 'Four', 'Five'};
varargin_copy = copy_varargin(varargin);
obj_copy = varargin_copy{1};  % should make a deep copy of the obj

assert(isequal(obj.name, 'deep copy') && ...
    isequal(obj_copy.name, 'deep copy'), ...
	[BRAPH2.STR ':copy_varargin:' BRAPH2.BUG_FUNC], ...
	'Deep-copy object not copied correctly by copy_varargin().')

obj.name = 'changed name';

assert(isequal(obj.name, 'changed name') && ...
    isequal(obj_copy.name, 'deep copy'), ...
	[BRAPH2.STR ':copy_varargin:' BRAPH2.BUG_FUNC], ...
	'Deep-copy object not copied correctly by copy_varargin().')