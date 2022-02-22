%EXAMPLE_FUN_WU
% Script example pipeline FUN WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_FUN_WU')) filesep 'example data FUN (fMRI)' filesep 'craddock_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_FUN_WU')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_FUN_WU')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis FUN WU
a_WU1 = AnalyzeEnsemble_FUN_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_FUN_WU( ...
    'GR', gr2 ...
    );

% measure calculation
degree_WU1 = a_WU1.getMeasureEnsemble('Degree').get('M');
degree_av_WU1 = a_WU1.getMeasureEnsemble('DegreeAv').get('M');
distance_WU1 = a_WU1.getMeasureEnsemble('Distance').get('M');

degree_WU2 = a_WU2.getMeasureEnsemble('Degree').get('M');
degree_av_WU2 = a_WU2.getMeasureEnsemble('DegreeAv').get('M');
distance_WU2 = a_WU2.getMeasureEnsemble('Distance').get('M');

% comparison
c_WU = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

degree_WU_diff = c_WU.getComparison('Degree', 'USE_COVARIATES', true).get('DIFF');
degree_WU_p1 = c_WU.getComparison('Degree', 'USE_COVARIATES', true).get('P1');
degree_WU_p2 = c_WU.getComparison('Degree', 'USE_COVARIATES', true).get('P2');
degree_WU_cil = c_WU.getComparison('Degree', 'USE_COVARIATES', true).get('CIL');
degree_WU_ciu = c_WU.getComparison('Degree', 'USE_COVARIATES', true).get('CIU');

degree_av_WU_diff = c_WU.getComparison('DegreeAv', 'USE_COVARIATES', true).get('DIFF');
degree_av_WU_p1 = c_WU.getComparison('DegreeAv', 'USE_COVARIATES', true).get('P1');
degree_av_WU_p2 = c_WU.getComparison('DegreeAv', 'USE_COVARIATES', true).get('P2');
degree_av_WU_cil = c_WU.getComparison('DegreeAv', 'USE_COVARIATES', true).get('CIL');
degree_av_WU_ciu = c_WU.getComparison('DegreeAv').get('CIU');

distance_WU_diff = c_WU.getComparison('Distance', 'USE_COVARIATES', true).get('DIFF');
distance_WU_p1 = c_WU.getComparison('Distance', 'USE_COVARIATES', true).get('P1');
distance_WU_p2 = c_WU.getComparison('Distance', 'USE_COVARIATES', true).get('P2');
distance_WU_cil = c_WU.getComparison('Distance', 'USE_COVARIATES', true).get('CIL');
distance_WU_ciu = c_WU.getComparison('Distance', 'USE_COVARIATES', true).get('CIU');