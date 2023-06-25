%EXAMPLE_FUN_MP_BUT
% Script example pipeline FUN MP BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN_MP

im_gr1 = ImporterGroupSubjectFUN_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP XLS' filesep 'FUN_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP XLS' filesep 'FUN_MP_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis FUN MP BUT
thresholds = .7:.1:.9;

a_BUT1 = AnalyzeEnsemble_FUN_MP_BUT( ...
    'GR', gr1, ...
    'THRESHOLDS', thresholds ...
    );

a_BUT2 = AnalyzeEnsemble_FUN_MP_BUT( ... 
    'TEMPLATE', a_BUT1, ...
    'GR', gr2, ...
    'THRESHOLDS', thresholds ...
    );

% measure calculation
degree_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % mpc_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'MultiplexParticipation').get('M');
% % % mpc_av_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'MultiplexParticipationAv').get('M');
% % % edgeov_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

degree_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % degree_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'MultiplexParticipation').get('M');
% % % degree_av_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'MultiplexParticipationAv').get('M');
% % % edgeov_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

% comparison
c_BUT = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_BUT1, ...
    'A2', a_BUT2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

degree_BUT_diff = c_BUT.get('COMPARISON', 'Degree').get('DIFF');
degree_BUT_p1 = c_BUT.get('COMPARISON', 'Degree').get('P1');
degree_BUT_p2 = c_BUT.get('COMPARISON', 'Degree').get('P2');
degree_BUT_cil = c_BUT.get('COMPARISON', 'Degree').get('CIL');
degree_BUT_ciu = c_BUT.get('COMPARISON', 'Degree').get('CIU');

degreeav_BUT_diff = c_BUT.get('COMPARISON', 'DegreeAv').get('DIFF');
degreeav_BUT_p1 = c_BUT.get('COMPARISON', 'DegreeAv').get('P1');
degreeav_BUT_p2 = c_BUT.get('COMPARISON', 'DegreeAv').get('P2');
degreeav_BUT_cil = c_BUT.get('COMPARISON', 'DegreeAv').get('CIL');
degreeav_BUT_ciu = c_BUT.get('COMPARISON', 'DegreeAv').get('CIU');

distance_BUT_diff = c_BUT.get('COMPARISON', 'Distance').get('DIFF');
distance_BUT_p1 = c_BUT.get('COMPARISON', 'Distance').get('P1');
distance_BUT_p2 = c_BUT.get('COMPARISON', 'Distance').get('P2');
distance_BUT_cil = c_BUT.get('COMPARISON', 'Distance').get('CIL');
distance_BUT_ciu = c_BUT.get('COMPARISON', 'Distance').get('CIU');

% % % mpc_BUT_diff = c_BUT.get('COMPARISON', 'MultiplexParticipation').get('DIFF');
% % % mpc_BUT_p1 = c_BUT.get('COMPARISON', 'MultiplexParticipation').get('P1');
% % % mpc_BUT_p2 = c_BUT.get('COMPARISON', 'MultiplexParticipation').get('P2');
% % % mpc_BUT_cil = c_BUT.get('COMPARISON', 'MultiplexParticipation').get('CIL');
% % % mpc_BUT_ciu = c_BUT.get('COMPARISON', 'MultiplexParticipation').get('CIU');

% % % mpc_av_BUT_diff = c_BUT.get('COMPARISON', 'MultiplexParticipationAv').get('DIFF');
% % % mpc_av_BUT_p1 = c_BUT.get('COMPARISON', 'MultiplexParticipationAv').get('P1');
% % % mpc_av_BUT_p2 = c_BUT.get('COMPARISON', 'MultiplexParticipationAv').get('P2');
% % % mpc_av_BUT_cil = c_BUT.get('COMPARISON', 'MultiplexParticipationAv').get('CIL');

% % % edgeov_BUT_diff = c_BUT.get('COMPARISON', 'EdgeOverlap').get('DIFF');
% % % edgeov_BUT_p1 = c_BUT.get('COMPARISON', 'EdgeOverlap').get('P1');
% % % edgeov_BUT_p2 = c_BUT.get('COMPARISON', 'EdgeOverlap').get('P2');
% % % edgeov_BUT_cil = c_BUT.get('COMPARISON', 'EdgeOverlap').get('CIL');
% % % edgeov_BUT_ciu = c_BUT.get('COMPARISON', 'EdgeOverlap').get('CIU');
% % % mpc_av_BUT_ciu = c_BUT.get('COMPARISON', 'MultiplexParticipationAv').get('CIU');