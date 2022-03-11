%% ¡header!
NNSubject < Subject (sub, subject with connectivity matrix) is a subject with connectivity matrix (e.g. DTI).

%%% ¡description!
Subject with a connectivity matrix (e.g. obtained from DTI).

%%% ¡seealso!
Element, Subject

%% ¡props!

%%% ¡prop!
G (data, item) is the input of the subject for a neural network.
%%%% ¡settings!
'Graph'

%%% ¡prop!
INPUT (data, cell) is the input of the subject for a neural network.
% % %%%% ¡gui!
% % pr = PPSubjectCON_CON('EL', sub, 'PROP', SubjectCON.CON, varargin{:})

%%% ¡prop!
INPUT_FS (data, cell) is the selected input by feature mask of the subject for a neural network.
% % %%%% ¡gui!
% % pr = PPSubjectCON_CON('EL', sub, 'PROP', SubjectCON.CON, varargin{:});

%%% ¡prop!
TARGET (data, cell) is the target of the subject for a neural network.

%%% ¡prop!
PREDICTION (data, cell) is the prediction of the subject from a neural network.

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'
%%%% ¡default!
BrainAtlas()

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
