%EXAMPLE_ST_BUT
% Script example workflow ST BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_BUT')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_BUT')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis BUT
a_BUT1 = AnalyzeGroup_ST_BUT('GR', gr1, 'Thresholds', [.5 .6]);

a_BUT2 = AnalyzeGroup_ST_BUT('GR', gr2, 'Thresholds', [.5 .6]);

% measure calculation
g_BUT1 = a_BUT1.get('G');
degree_BUT1 = g_BUT1.getMeasure('Degree').get('M');
degree_av_BUT1 = g_BUT1.getMeasure('DegreeAv').get('M');
distance_BUT1 = g_BUT1.getMeasure('Distance').get('M');

g_BUT2 = a_BUT2.get('G');
degree_BUT1 = g_BUT2.getMeasure('Degree').get('M');
degree_av_BUT1 = g_BUT2.getMeasure('DegreeAv').get('M');
distance_BUT1 = g_BUT2.getMeasure('Distance').get('M');

% comparison
c_BUT = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUT1, ...
    'A2', a_BUT2 ...
    );

degree_BUT_p1 = c_BUT.getComparison('Degree').get('P1');
degree_BUT_p2 = c_BUT.getComparison('Degree').get('P2');
degree_BUT_cil = c_BUT.getComparison('Degree').get('CIL');
degree_BUT_ciu = c_BUT.getComparison('Degree').get('CIU');

degree_av_BUT_p1 = c_BUT.getComparison('DegreeAv').get('P1');
degree_av_BUT_p2 = c_BUT.getComparison('DegreeAv').get('P2');
degree_av_BUT_cil = c_BUT.getComparison('DegreeAv').get('CIL');
degree_av_BUT_ciu = c_BUT.getComparison('DegreeAv').get('CIU');

distance_BUT_p1 = c_BUT.getComparison('Distance').get('P1');
distance_BUT_p2 = c_BUT.getComparison('Distance').get('P2');
distance_BUT_cil = c_BUT.getComparison('Distance').get('CIL');
distance_BUT_ciu = c_BUT.getComparison('Distance').get('CIU');
