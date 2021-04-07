%EXAMPLE_ST_WU
% Script example workflow ST WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST WU
a_WU1 = AnalysisGroup_ST_WU('GR', gr1);

a_WU2 = AnalysisGroup_ST_WU('GR', gr2);

% measure calculation
g_WU1 = a_WU1.get('G');
degree_WU1 = g_WU1.getMeasure('Degree').get('M');
degree_av_WU1 = g_WU1.getMeasure('DegreeAv').get('M');
distance_WU1 = g_WU1.getMeasure('Distance').get('M');

g_WU2 = a_WU2.get('G');
degree_WU1 = g_WU2.getMeasure('Degree').get('M');
degree_av_WU1 = g_WU2.getMeasure('DegreeAv').get('M');
distance_WU1 = g_WU2.getMeasure('Distance').get('M');

% % comparison
% c_WU = Comparison( ...
%     'P', 10, ...
%     'A1', a_WU1, ...
%     'A2', a_WU2 ...
%     );
% 
% [degree_WU_p1, degree_WU_p2, degree_WU_ci_lower, degree_WU_ci_upper, ...
%     degree_WU_m1, degree_WU_m2, degree_WU_diff, ...
%     degree_WU_m1_perms, degree_WU_m2_perms, degree_WU_diff_perms] = c_WU.getComparison('Degree', 'verbose', true);
% [degree_av_WU_p1, degree_av_WU_p2, degree_av_WU_ci_lower, degree_av_WU_ci_upper, ...
%     degree_av_WU_m1, degree_av_WU_m2, degree_av_WU_diff, ...
%     degree_av_WU_m1_perms, degree_av_WU_m2_perms, degree_av_WU_diff_perms] = c_WU.getComparison('DegreeAv', 'verbose', true);
% [distance_WU_p1, distance_WU_p2, distance_WU_ci_lower, distance_WU_ci_upper, ...
%     distance_WU_m1, distance_WU_m2, distance_WU_diff, ...
%     distance_WU_m1_perms, distance_WU_m2_perms, distance_WU_diff_perms] = c_WU.getComparison('Distance', 'verbose', true);