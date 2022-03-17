%% ¡header!
NNSubject < Subject (sub, subject with connectivity matrix) is a subject for the neural network analysis.

%%% ¡description!
NNSubject contains the required information for individual to be analyzed by neural network analysis.

%%% ¡seealso!
Element, Subject

%% ¡props!

%%% ¡prop!
G (data, item) is a graph obtained from the data of the subject.
%%%% ¡settings!
'Graph'

%%% ¡prop!
INPUT (data, cell) is the input obtained from the data of subject for the neural network analysis.
% % %%%% ¡gui!
% % pr = PPSubjectCON_CON('EL', sub, 'PROP', SubjectCON.CON, varargin{:})

%%% ¡prop!
INPUT_FS (data, cell) is the input with feature selection.
% % %%%% ¡gui!
% % pr = PPSubjectCON_CON('EL', sub, 'PROP', SubjectCON.CON, varargin{:});

%%% ¡prop!
TARGET (data, string) is the target of the subject for the neural network analysis.

%%% ¡prop!
PREDICTION (data, cell) is the prediction of the subject from the neural network analysis.

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