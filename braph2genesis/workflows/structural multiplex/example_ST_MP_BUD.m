%EXAMPLE_ST_MP_BUD
% Script example workflow ST MP BUD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_MP_BUD')) filesep 'example data ST_MP (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST

im_gr1 = ImporterGroupSubjectSTMPXLS( ...
    'DIRECTORY', [fileparts(which('example_ST_MP_BUD')) filesep 'example data ST_MP (MRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTMPXLS( ...
    'DIRECTORY', [fileparts(which('example_ST_MP_BUD')) filesep 'example data ST_MP (MRI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST MP BUD
a_BUD1 = AnalyzeGroup_ST_MP_BUD('GR', gr1);

a_BUD2 = AnalyzeGroup_ST_MP_BUD('GR', gr2);

% measure calculation
g_BUD1 = a_BUD1.get('G');
degree_BUD1 = g_BUD1.getMeasure('Degree').get('M');
degree_av_BUD1 = g_BUD1.getMeasure('DegreeAv').get('M');
distance_BUD1 = g_BUD1.getMeasure('Distance').get('M');

g_BUD2 = a_BUD2.get('G');
degree_BUD2 = g_BUD2.getMeasure('Degree').get('M');
degree_av_BUD2 = g_BUD2.getMeasure('DegreeAv').get('M');
distance_BUD2 = g_BUD2.getMeasure('Distance').get('M');

% comparison
c_BUD = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUD1, ...
    'A2', a_BUD2, ...
    'VERBOSE', true, ...
    'MEMORIZE', true ...
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