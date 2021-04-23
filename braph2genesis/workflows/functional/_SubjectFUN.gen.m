%% ¡header!
SubjectFUN  < Subject (sub, subject with time series) is a subject with time series (e.g. fMRI).

%%% ¡description!
Subject with functional data (e.g. activation timeseries) for each brain region. 
For example, functional data can be fMRI or EEG.

%%% ¡seealso!
Element, Subject

%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
FUN (data, matrix) is a matrix with each column corresponding to the time series of a brain region.
%%%% ¡check_value!
br_number = sub.get('BA').get('BR_DICT').length();
check = size(value, 2) == br_number; % Format.checkFormat(Format.MATRIX, value) already checked
if check
    msg = 'All ok!';
else   
    msg = ['FUN must be a matrix with the same number of columns as the brain regions (' int2str(br_number) ').'];
end
 
%%% ¡prop!
age (data, scalar) is a scalar number containing the age of the subject.
%%%% ¡default!
0

%%% ¡prop!
sex (data, option) is an option containing the sex of the subject (female/male).
%%%% ¡default!
'unassigned'