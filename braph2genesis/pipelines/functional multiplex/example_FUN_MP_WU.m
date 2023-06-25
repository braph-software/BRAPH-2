%EXAMPLE_FUN_MP_WU
% Script example pipeline FUN MP WU

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

%% Analysis FUN_MP WU
a_WU1 = AnalyzeEnsemble_FUN_MP_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_FUN_MP_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

% measure calculation
degree_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_WU1 = a_WU1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % wmpc_WU1 = a_WU1.get('MEASUREENSEMBLE', 'WeightedMultiplexParticipation').get('M');
% % % wmpc_av_WU1 = a_WU1.get('MEASUREENSEMBLE', 'WeightedMultiplexParticipationAv').get('M');
% % % weo_WU1 = a_WU1.get('MEASUREENSEMBLE', 'WeightedEdgeOverlap').get('M');

degree_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_WU2 = a_WU2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % wmpc_WU2 = a_WU2.get('MEASUREENSEMBLE', 'WeightedMultiplexParticipation').get('M');
% % % wmpc_av_WU2 = a_WU2.get('MEASUREENSEMBLE', 'WeightedMultiplexParticipationAv').get('M');
% % % weo_WU2 = a_WU2.get('MEASUREENSEMBLE', 'WeightedEdgeOverlap').get('M');

% comparison
c_WU = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

degree_WU_diff = c_WU.get('COMPARISON', 'Degree').get('DIFF');
degree_WU_p1 = c_WU.get('COMPARISON', 'Degree').get('P1');
degree_WU_p2 = c_WU.get('COMPARISON', 'Degree').get('P2');
degree_WU_cil = c_WU.get('COMPARISON', 'Degree').get('CIL');
degree_WU_ciu = c_WU.get('COMPARISON', 'Degree').get('CIU');

degreeav_WU_diff = c_WU.get('COMPARISON', 'DegreeAv').get('DIFF');
degreeav_WU_p1 = c_WU.get('COMPARISON', 'DegreeAv').get('P1');
degreeav_WU_p2 = c_WU.get('COMPARISON', 'DegreeAv').get('P2');
degreeav_WU_cil = c_WU.get('COMPARISON', 'DegreeAv').get('CIL');
degreeav_WU_ciu = c_WU.get('COMPARISON', 'DegreeAv').get('CIU');

distance_WU_diff = c_WU.get('COMPARISON', 'Distance').get('DIFF');
distance_WU_p1 = c_WU.get('COMPARISON', 'Distance').get('P1');
distance_WU_p2 = c_WU.get('COMPARISON', 'Distance').get('P2');
distance_WU_cil = c_WU.get('COMPARISON', 'Distance').get('CIL');
distance_WU_ciu = c_WU.get('COMPARISON', 'Distance').get('CIU');

% % % wmpc_WU_diff = c_WU.get('COMPARISON', 'WeightedMultiplexParticipation').get('DIFF');
% % % wmpc_WU_p1 = c_WU.get('COMPARISON', 'WeightedMultiplexParticipation').get('P1');
% % % wmpc_WU_p2 = c_WU.get('COMPARISON', 'WeightedMultiplexParticipation').get('P2');
% % % wmpc_WU_cil = c_WU.get('COMPARISON', 'WeightedMultiplexParticipation').get('CIL');
% % % wmpc_WU_ciu = c_WU.get('COMPARISON', 'WeightedMultiplexParticipation').get('CIU');

% % % wmpc_av_WU_diff = c_WU.get('COMPARISON', 'WeightedMultiplexParticipationAv').get('DIFF');
% % % wmpc_av_WU_p1 = c_WU.get('COMPARISON', 'WeightedMultiplexParticipationAv').get('P1');
% % % wmpc_av_WU_p2 = c_WU.get('COMPARISON', 'WeightedMultiplexParticipationAv').get('P2');
% % % wmpc_av_WU_cil = c_WU.get('COMPARISON', 'WeightedMultiplexParticipationAv').get('CIL');
% % % wmpc_av_WU_ciu = c_WU.get('COMPARISON', 'WeightedMultiplexParticipationAv').get('CIU');

% % % weo_WU_diff = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('DIFF');
% % % weo_WU_p1 = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('P1');
% % % weo_WU_p2 = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('P2');
% % % weo_WU_cil = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('CIL');
% % % weo_WU_ciu = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('CIU');