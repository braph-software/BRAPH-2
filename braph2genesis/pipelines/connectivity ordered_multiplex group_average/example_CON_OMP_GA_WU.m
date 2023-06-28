%EXAMPLE_CON_OMP_GA_WU
% Script example pipeline CON OMP GA WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectCON_MP')) filesep 'Example data CON_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON_MP
im_gr1 = ImporterGroupSubjectCON_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_MP')) filesep 'Example data CON_MP XLS' filesep 'CON_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectCON_MP')) filesep 'Example data CON_MP XLS' filesep 'CON_MP_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis CON_OMP GA WU
a_WU1 = AnalyzeGroup_CON_OMP_GA_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeGroup_CON_OMP_GA_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

% measure calculation
g_WU1 = a_WU1.get('G');
degree_WU1 = g_WU1.get('MEASURE', 'Degree').get('M');
% % % wmpc_WU1 = g_WU1.get('MEASURE', 'WeightedMultiplexParticipation').get('M');
% % % wmpc_av_WU1 = g_WU1.get('MEASURE', 'WeightedMultiplexParticipationAv').get('M');
% % % mcommunities_WU1 = g_WU1.get('MEASURE', 'MultilayerCommunityStructure').get('M');

g_WU2 = a_WU2.get('G');
degree_WU2 = g_WU2.get('MEASURE', 'Degree').get('M');
% % % wmpc_WU2 = g_WU2.get('MEASURE', 'WeightedMultiplexParticipation').get('M');
% % % wmpc_av_WU2 = g_WU2.get('MEASURE', 'WeightedMultiplexParticipationAv').get('M');
% % % mcommunities_WU2 = g_WU2.get('MEASURE', 'MultilayerCommunityStructure').get('M');

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

% % % overlappingdegree_WU_diff = c_WU.get('COMPARISON', 'OverlappingDegree').get('DIFF');
% % % overlappingdegree_WU_p1 = c_WU.get('COMPARISON', 'OverlappingDegree').get('P1');
% % % overlappingdegree_WU_p2 = c_WU.get('COMPARISON', 'OverlappingDegree').get('P2');
% % % overlappingdegree_WU_cil = c_WU.get('COMPARISON', 'OverlappingDegree').get('CIL');
% % % overlappingdegree_WU_ciu = c_WU.get('COMPARISON', 'OverlappingDegree').get('CIU');

% % % overlappingdegree_av_WU_diff = c_WU.get('COMPARISON', 'OverlappingDegreeAv').get('DIFF');
% % % overlappingdegree_av_WU_p1 = c_WU.get('COMPARISON', 'OverlappingDegreeAv').get('P1');
% % % overlappingdegree_av_WU_p2 = c_WU.get('COMPARISON', 'OverlappingDegreeAv').get('P2');
% % % overlappingdegree_av_WU_cil = c_WU.get('COMPARISON', 'OverlappingDegreeAv').get('CIL');
% % % overlappingdegree_av_WU_ciu = c_WU.get('COMPARISON', 'OverlappingDegreeAv').get('CIU');

% % % mcommunities_WU_diff = c_WU.get('COMPARISON', 'MultilayerCommunityStructure').get('DIFF');
% % % mcommunities_WU_p1 = c_WU.get('COMPARISON', 'MultilayerCommunityStructure').get('P1');
% % % mcommunities_WU_p2 = c_WU.get('COMPARISON', 'MultilayerCommunityStructure').get('P2');
% % % mcommunities_WU_cil = c_WU.get('COMPARISON', 'MultilayerCommunityStructure').get('CIL');
% % % mcommunities_WU_ciu = c_WU.get('COMPARISON', 'MultilayerCommunityStructure').get('CIU');