%EXAMPLE_FUN_OMP_GA_WU
% Script example pipeline FUN OMP GA WU

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
a_WU1 = AnalyzeGroup_FUN_OMP_GA_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeGroup_FUN_OMP_GA_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

% measure calculation
g_WU1 = a_WU1.get('G');
degree_WU1 = g_WU1.get('MEASURE', 'Degree').get('M');
% % % wmpc_WU1 = g_WU1.get('MEASURE', 'WeightedMultiplexParticipation').get('M');
% % % wmpc_av_WU1 = g_WU1.get('MEASURE', 'WeightedMultiplexParticipationAv').get('M');
% % % weo_WU1 = g_WU1.get('MEASURE', 'WeightedEdgeOverlap').get('M');

g_WU2 = a_WU2.get('G');
degree_WU2 = g_WU2.get('MEASURE', 'Degree').get('M');
% % % wmpc_WU2 = g_WU2.get('MEASURE', 'WeightedMultiplexParticipation').get('M');
% % % wmpc_av_WU2 = g_WU2.get('MEASURE', 'WeightedMultiplexParticipationAv').get('M');
% % % weo_WU2 = g_WU2.get('MEASURE', 'WeightedEdgeOverlap').get('M');

% comparison
c_WU = CompareGroup( ...
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

% % % weo_av_WU_diff = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('DIFF');
% % % weo_av_WU_p1 = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('P1');
% % % weo_av_WU_p2 = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('P2');
% % % weo_av_WU_cil = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('CIL');
% % % weo_av_WU_ciu = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('CIU');