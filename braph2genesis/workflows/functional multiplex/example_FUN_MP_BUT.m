%EXAMPLE_FUN_MP_BUT
% Script example workflow FUN_MP BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_FUN_MP_BUT')) filesep 'example data FUN_MP (fMRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN_MP

im_gr1 = ImporterGroupSubjectFUNMPXLS( ...
    'DIRECTORY', [fileparts(which('example_FUN_MP_BUT')) filesep 'example data FUN_MP (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'FILE_COVARIATES', [fileparts(which('example_FUN_MP_BUT')) filesep 'example data FUN_MP (fMRI)' filesep 'xls' filesep 'covariates_age_sex' filesep 'GroupName1_age_sex.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUNMPXLS( ...
    'DIRECTORY', [fileparts(which('example_FUN_MP_BUT')) filesep 'example data FUN_MP (fMRI)' filesep 'xls' filesep 'GroupName2'], ...
    'FILE_COVARIATES', [fileparts(which('example_FUN_MP_BUT')) filesep 'example data FUN_MP (fMRI)' filesep 'xls' filesep 'covariates_age_sex' filesep 'GroupName2_age_sex.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis FUN MP BUT
a_BUT1 = AnalyzeGroup_FUN_MP_BUT('GR', gr1);

a_BUT2 = AnalyzeGroup_FUN_MP_BUT('GR', gr2);

% measure calculation
g_BUT1 = a_BUT1.get('G');
degree_BUT1 = g_BUT1.getMeasure('Degree').get('M');
degree_av_BUT1 = g_BUT1.getMeasure('DegreeAv').get('M');
distance_BUT1 = g_BUT1.getMeasure('Distance').get('M');

g_BUT2 = a_BUT2.get('G');
degree_BUT2 = g_BUT2.getMeasure('Degree').get('M');
degree_av_BUT2 = g_BUT2.getMeasure('DegreeAv').get('M');
distance_BUT2 = g_BUT2.getMeasure('Distance').get('M');

% comparison
c_BUT = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUT1, ...
    'A2', a_BUT2, ...
    'VERBOSE', true, ...
    'MEMORIZE', true ...
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