%EXAMPLE_CON_MP_WU
% Script example pipeline CON MP WU

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

%% Analysis CON_MP WU
a_WU1 = AnalyzeEnsemble_CON_MP_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_MP_WU( ...
    'TEMPLATE', a_WU1, ...
    'GR', gr2 ...
    );

% measure calculation
degree_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_WU1 = a_WU1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_WU1 = a_WU1.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % overlappingdegree_WU1 = a_WU1.get('MEASUREENSEMBLE', 'OverlappingDegree').get('M');
% % % overlappingdegree_av_WU1 = a_WU1.get('MEASUREENSEMBLE', 'OverlappingDegreeAv').get('M');
% % % wedgeoverlap_WU1 = a_WU1.get('MEASUREENSEMBLE', 'WeightedEdgeOverlap').get('M');

degree_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_WU2 = a_WU2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_WU2 = a_WU2.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % overlappingdegree_WU2 = a_WU2.get('MEASUREENSEMBLE', 'OverlappingDegree').get('M');
% % % overlappingdegree_av_WU2 = a_WU2.get('MEASUREENSEMBLE', 'OverlappingDegreeAv').get('M');
% % % wedgeoverlap_WU2 = a_WU2.get('MEASUREENSEMBLE', 'WeightedEdgeOverlap').get('M');

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

% % % wedgeoverlap_WU_diff = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('DIFF');
% % % wedgeoverlap_WU_p1 = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('P1');
% % % wedgeoverlap_WU_p2 = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('P2');
% % % wedgeoverlap_WU_cil = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('CIL');
% % % wedgeoverlap_WU_ciu = c_WU.get('COMPARISON', 'WeightedEdgeOverlap').get('CIU');