%EXAMPLE_CON_MP_BUT
% Script example pipeline CON MP BUT

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

%% Analysis CON MP BUT
thresholds = 0.4:0.2:0.8;

a_BUT1 = AnalyzeEnsemble_CON_MP_BUT( ...
    'GR', gr1, ...
    'THRESHOLDS', thresholds ...
    );

a_BUT2 = AnalyzeEnsemble_CON_MP_BUT( ... 
    'TEMPLATE', a_BUT1, ...
    'GR', gr2, ...
    'THRESHOLDS', thresholds ...
    );

% measure calculation
degree_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % overlappingdegree_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'OverlappingDegree').get('M');
% % % overlappingdegree_av_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'OverlappingDegreeAv').get('M');
% % % edgeoverlap_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

degree_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'Degree').get('M');
degreeav_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'DegreeAv').get('M');
distance_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'Distance').get('M');
% % % % overlappingdegree_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'OverlappingDegree').get('M');
% % % % overlappingdegree_av_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'OverlappingDegreeAv').get('M');
% % % % edgeoverlap_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

% comparison
c_BUT = CompareEnsemble( ...
    'P', 5, ...
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

% % % overlappingdegree_BUT_diff = c_BUT.get('COMPARISON', 'OverlappingDegree').get('DIFF');
% % % overlappingdegree_BUT_p1 = c_BUT.get('COMPARISON', 'OverlappingDegree').get('P1');
% % % overlappingdegree_BUT_p2 = c_BUT.get('COMPARISON', 'OverlappingDegree').get('P2');
% % % overlappingdegree_BUT_cil = c_BUT.get('COMPARISON', 'OverlappingDegree').get('CIL');
% % % overlappingdegree_BUT_ciu = c_BUT.get('COMPARISON', 'OverlappingDegree').get('CIU');

% % % overlappingdegree_av_BUT_diff = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('DIFF');
% % % overlappingdegree_av_BUT_p1 = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('P1');
% % % overlappingdegree_av_BUT_p2 = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('P2');
% % % overlappingdegree_av_BUT_cil = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('CIL');
% % % overlappingdegree_av_BUT_ciu = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('CIU');

% % % edgeoverlap_BUT_diff = c_BUT.get('COMPARISON', 'EdgeOverlap').get('DIFF');
% % % edgeoverlap_BUT_p1 = c_BUT.get('COMPARISON', 'EdgeOverlap').get('P1');
% % % edgeoverlap_BUT_p2 = c_BUT.get('COMPARISON', 'EdgeOverlap').get('P2');
% % % edgeoverlap_BUT_cil = c_BUT.get('COMPARISON', 'EdgeOverlap').get('CIL');
% % % edgeoverlap_BUT_ciu = c_BUT.get('COMPARISON', 'EdgeOverlap').get('CIU');