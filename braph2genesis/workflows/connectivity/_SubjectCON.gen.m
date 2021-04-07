%% ¡header!
SubjectCON < Subject (sub, subject with connectivity matrix) is a subject with connectivity matrix (e.g. DTI).

%%% ¡description!
Subject with a connectivity matrix (e.g. obtained from DTI).

%%% ¡seealso!
Element, Subject

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

%%% ¡prop!
CON (data, smatrix) is an adjacency matrix.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
check = isequal(size(value), [br_number, br_number]); % Format.checkFormat(Format.SMATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['CON must be a square matrix with the dimensiton equal to the number of brain regions (' int2str(br_number) ').'];
end