%EXAMPLE_ST_WU
% Script example workflow ST WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'FILE_COVARIATES', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'covariates_age_sex' filesep 'ST_group1_age_sex.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'FILE_COVARIATES', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'covariates_age_sex' filesep 'ST_group2_age_sex.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST WU
use_covariates_in_analysis = 'True';
a_WU1 = AnalyzeGroup_ST_WU('GR', gr1, use_covariates_in_analysis);

a_WU2 = AnalyzeGroup_ST_WU('GR', gr2, use_covariates_in_analysis);

% measure calculation
g_WU1 = a_WU1.get('G');
degree_WU1 = g_WU1.getMeasure('Degree').get('M');
degree_av_WU1 = g_WU1.getMeasure('DegreeAv').get('M');
distance_WU1 = g_WU1.getMeasure('Distance').get('M');

g_WU2 = a_WU2.get('G');
degree_WU2 = g_WU2.getMeasure('Degree').get('M');
degree_av_WU2 = g_WU2.getMeasure('DegreeAv').get('M');
distance_WU2 = g_WU2.getMeasure('Distance').get('M');

% comparison
c_WU = CompareGroup( ...
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'VERBOSE', true, ...
    'MEMORIZE', true ...
    );

degree_WU_p1 = c_WU.getComparison('Degree').get('P1');
degree_WU_p2 = c_WU.getComparison('Degree').get('P2');
degree_WU_cil = c_WU.getComparison('Degree').get('CIL');
degree_WU_ciu = c_WU.getComparison('Degree').get('CIU');

degree_av_WU_p1 = c_WU.getComparison('DegreeAv').get('P1');
degree_av_WU_p2 = c_WU.getComparison('DegreeAv').get('P2');
degree_av_WU_cil = c_WU.getComparison('DegreeAv').get('CIL');
degree_av_WU_ciu = c_WU.getComparison('DegreeAv').get('CIU');

distance_WU_p1 = c_WU.getComparison('Distance').get('P1');
distance_WU_p2 = c_WU.getComparison('Distance').get('P2');
distance_WU_cil = c_WU.getComparison('Distance').get('CIL');
distance_WU_ciu = c_WU.getComparison('Distance').get('CIU');