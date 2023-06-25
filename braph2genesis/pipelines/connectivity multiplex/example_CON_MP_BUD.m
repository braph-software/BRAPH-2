%EXAMPLE_CON_MP_BUD
% Script example pipeline CON MP BUD

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

%% Analysis CON MP BUD
densities = 1:3:10;

a_BUD1 = AnalyzeEnsemble_CON_MP_BUD( ...
    'GR', gr1, ...
    'DENSITIES', densities ...
    );

a_BUD2 = AnalyzeEnsemble_CON_MP_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr2, ...
    'DENSITIES', densities ...
    );

% measure calculation
degree_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % overlappingdegree_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'OverlappingDegree').get('M');
% % % overlappingdegree_av_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'OverlappingDegreeAv').get('M');
% % % edgeoverlap_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

degree_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % overlappingdegree_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'OverlappingDegree').get('M');
% % % overlappingdegree_av_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'OverlappingDegreeAv').get('M');
% % % edgeoverlap_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

% comparison
c_BUD = CompareEnsemble( ...
    'P', 5, ...
    'A1', a_BUD1, ...
    'A2', a_BUD2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

degree_BUD_diff = c_BUD.get('COMPARISON', 'Degree').get('DIFF');
degree_BUD_p1 = c_BUD.get('COMPARISON', 'Degree').get('P1');
degree_BUD_p2 = c_BUD.get('COMPARISON', 'Degree').get('P2');
degree_BUD_cil = c_BUD.get('COMPARISON', 'Degree').get('CIL');
degree_BUD_ciu = c_BUD.get('COMPARISON', 'Degree').get('CIU');

degreeav_BUD_diff = c_BUD.get('COMPARISON', 'DegreeAv').get('DIFF');
degreeav_BUD_p1 = c_BUD.get('COMPARISON', 'DegreeAv').get('P1');
degreeav_BUD_p2 = c_BUD.get('COMPARISON', 'DegreeAv').get('P2');
degreeav_BUD_cil = c_BUD.get('COMPARISON', 'DegreeAv').get('CIL');
degreeav_BUD_ciu = c_BUD.get('COMPARISON', 'DegreeAv').get('CIU');

distance_BUD_diff = c_BUD.get('COMPARISON', 'Distance').get('DIFF');
distance_BUD_p1 = c_BUD.get('COMPARISON', 'Distance').get('P1');
distance_BUD_p2 = c_BUD.get('COMPARISON', 'Distance').get('P2');
distance_BUD_cil = c_BUD.get('COMPARISON', 'Distance').get('CIL');
distance_BUD_ciu = c_BUD.get('COMPARISON', 'Distance').get('CIU');

% % % overlappingdegree_BUD_diff = c_BUD.get('COMPARISON', 'OverlappingDegree').get('DIFF');
% % % overlappingdegree_BUD_p1 = c_BUD.get('COMPARISON', 'OverlappingDegree').get('P1');
% % % overlappingdegree_BUD_p2 = c_BUD.get('COMPARISON', 'OverlappingDegree').get('P2');
% % % overlappingdegree_BUD_cil = c_BUD.get('COMPARISON', 'OverlappingDegree').get('CIL');
% % % overlappingdegree_BUD_ciu = c_BUD.get('COMPARISON', 'OverlappingDegree').get('CIU');

% % % overlappingdegree_av_BUD_diff = c_BUD.get('COMPARISON', 'OverlappingDegreeAv').get('DIFF');
% % % overlappingdegree_av_BUD_p1 = c_BUD.get('COMPARISON', 'OverlappingDegreeAv').get('P1');
% % % overlappingdegree_av_BUD_p2 = c_BUD.get('COMPARISON', 'OverlappingDegreeAv').get('P2');
% % % overlappingdegree_av_BUD_cil = c_BUD.get('COMPARISON', 'OverlappingDegreeAv').get('CIL');
% % % overlappingdegree_av_BUD_ciu = c_BUD.get('COMPARISON', 'OverlappingDegreeAv').get('CIU');

% % % edgeoverlap_BUD_diff = c_BUD.get('COMPARISON', 'EdgeOverlap').get('DIFF');
% % % edgeoverlap_BUD_p1 = c_BUD.get('COMPARISON', 'EdgeOverlap').get('P1');
% % % edgeoverlap_BUD_p2 = c_BUD.get('COMPARISON', 'EdgeOverlap').get('P2');
% % % edgeoverlap_BUD_cil = c_BUD.get('COMPARISON', 'EdgeOverlap').get('CIL');
% % % edgeoverlap_BUD_ciu = c_BUD.get('COMPARISON', 'EdgeOverlap').get('CIU');