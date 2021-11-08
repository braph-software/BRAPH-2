%EXAMPLE_CON_FUN_MP_WU
% Script example workflow CON_FUN_MP WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCONXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'connectivity' filesep 'GroupName1'], ...
    'BA', ba ...
    );

gr1_CON = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCONXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'connectivity' filesep 'GroupName2'], ...
    'BA', ba ...
    );

gr2_CON = im_gr2.get('GR');

%% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUNXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'functional' filesep 'GroupName1'], ...
    'BA', ba ...
    );

gr1_FUN = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUNXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_WU')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'functional' filesep 'GroupName2'], ...
    'BA', ba ...
    );

gr2_FUN = im_gr2.get('GR');

%% Combine Groups of SubjectCON with Groups of SubjectFUN
co_gr1 = CombineGroups_CON_FUN( ...
    'GR1', gr1_CON, ...
    'GR2', gr1_FUN ...
    );

gr1 = co_gr1.get('GR');

co_gr2 = CombineGroups_CON_FUN( ...
    'GR1', gr2_CON, ...
    'GR2', gr2_FUN ...
    );

gr2 = co_gr2.get('GR');

%% Analysis CON_FUN_MP WU
a_WU1 = AnalyzeEnsemble_CON_FUN_MP_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeEnsemble_CON_FUN_MP_WU( ...
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