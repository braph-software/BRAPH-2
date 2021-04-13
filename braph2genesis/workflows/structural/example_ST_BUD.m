%EXAMPLE_ST_BUD
% Script example workflow ST BUD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis BUD
densities = [0 100];
a_BUD_1 = AnalyzeGroup_ST_BUD('GR', gr1, 'DENSITIES', densities);

a_BUD_2 = AnalyzeGroup_ST_BUD('GR', gr2, 'DENSITIES', densities);

% measure calculation
g_BUD_1 = a_BUD_1.get('G');
degree_BUD_1 = g_BUD_1.getMeasure('Degree').get('M');
degree_av_BUD_1 = g_BUD_1.getMeasure('DegreeAv').get('M');
distance_BUD_1 = g_BUD_1.getMeasure('Distance').get('M');

g_BUD_2 = a_BUD_2.get('G');
degree_BUD_2 = g_BUD_2.getMeasure('Degree').get('M');
degree_av_BUD_2 = g_BUD_2.getMeasure('DegreeAv').get('M');
distance_BUD_2 = g_BUD_2.getMeasure('Distance').get('M');

% comparison
c_BUD = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUD_1, ...
    'A2', a_BUD_2 ...
    );

degree_BUD_p1 = c_BUD.getComparison('Degree').get('P1');
degree_BUD_p2 = c_BUD.getComparison('Degree').get('P2');
degree_BUD_cil = c_BUD.getComparison('Degree').get('CIL');
degree_BUD_ciu = c_BUD.getComparison('Degree').get('CIU');

degree_av_BUD_p1 = c_BUD.getComparison('DegreeAv').get('P1');
degree_av_BUD_p2 = c_BUD.getComparison('DegreeAv').get('P2');
degree_av_BUD_cil = c_BUD.getComparison('DegreeAv').get('CIL');
degree_av_BUD_ciu = c_BUD.getComparison('DegreeAv').get('CIU');

distance_BUD_p1 = c_BUD.getComparison('Distance').get('P1');
distance_BUD_p2 = c_BUD.getComparison('Distance').get('P2');
distance_BUD_cil = c_BUD.getComparison('Distance').get('CIL');
distance_BUD_ciu = c_BUD.getComparison('Distance').get('CIU');
