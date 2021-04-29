%% ¡header!
SubjectCON_FUN_MP < Subject (sub, subject with connectivity and functional multiplex data) is a subject with connectivity and functional multiplex data (e.g. DTI and fMRI).

%%% ¡description!
Subject with a connectivity and functional multiplex data (e.g. obtained from DTI and fMRI).
The first layer contains a connectivity matrix and the second layer contains functional data.

%%% ¡seealso!
Element, Subject, SubjectCON, SubjectFUN

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
L (data, scalar) is the number of multiplex layers of subject.
%%%% ¡default!
2

%%% ¡prop!
CON_FUN_MP (data, cell) is a cell containing 2 matrices with connectivity and functional data.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
num_layers = sub.get('L');
check = (iscell(value) && isequal(length(value), num_layers)  && isequal(size(value{1}), [br_number, br_number]) && isequal(size(value{2}, 2), br_number)) || (isempty(value) && br_number == 0); 
if check
    msg = 'All ok!';
else   
    msg = ['CON_FUN_MP must be a cell with two matrices, the first with the same number of rows and columns as the brain regions and the second with ' ...
        'the same number of columns as the brain regions (' int2str(br_number) ').'];
end
 
%%% ¡prop!
age (data, scalar) is a scalar number containing the age of the subject.
%%%% ¡default!
0

%%% ¡prop!
sex (data, option) is an option containing the sex of the subject (female/male).
%%%% ¡default!
'unassigned'
%%%% ¡settings!
{'Female', 'Male', 'unassigned'}