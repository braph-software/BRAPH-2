% test clean_varargin

%% Test 1: Empty
handles = {'h1', 'h2', 'h3'};
varargin = {};

varargin_clean = clean_varargin(handles, varargin{:});

assert(isequal(varargin_clean, varargin), ...
    'BRAPH:clean_varargin:Bug', ...
    'Not working case empty.')

%% Test 2: Already clean
handles = {'h1', 'h2', 'h3'};
varargin = {'h1', 1, 'h2', 2, 'h3', 3};

varargin_clean = clean_varargin(handles, varargin{:});

assert(isequal(varargin_clean, varargin), ...
    'BRAPH:clean_varargin:Bug', ...
    'Not working case already clean.')

%% Test 3: Need cleaning
handles = {'h1', 'h2', 'h3'};
varargin = {'e1', -1, 'h1', 1, 'e2', -2, 'h2', 2, 'e3', -3, 'h3', 3, 'e4', -4};

varargin_clean = clean_varargin(handles, varargin{:});

assert(isequal(varargin_clean, {'h1', 1, 'h2', 2, 'h3', 3}), ...
    'BRAPH:clean_varargin:Bug', ...
    'Not working case needing cleaning.')

%% Test 4: Need complete cleaning
handles = {'h1', 'h2', 'h3'};
varargin = {'e1', -1, 'e2', -2, 'e3', -3, 'e4', -4};

varargin_clean = clean_varargin(handles, varargin{:});

assert(isempty(varargin_clean), ...
    'BRAPH:clean_varargin:Bug', ...
    'Not working case needing complete cleaning.')
