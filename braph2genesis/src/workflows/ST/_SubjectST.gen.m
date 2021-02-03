%% ¡header!
SubjectST < Subject (sub, subject with structural data) is a subject with structural data (e.g. MRI).

%%% ¡description!
Subject with structural data (such as cortical thickness) for each brain region.
For example, structural data can be MRI.

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
ST (data, cvector) is a column vector with data for each brain region.
%%%% ¡check!
br_number = sub.get('BA').get('BR_DICT').length();
check = (iscolumn(value) && isequal(size(value), [br_number, 1])) || (isempty(value) && br_number == 0); % Format.checkFormat(Format.CVECTOR, value) already checked
msg = ['ST must be a column vector with the same number of element as the brain regions (' int2str(br_number) ').'];
%%%% ¡default!
[]