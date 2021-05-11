%EXAMPLE_CON_FUN_MP_BUD
% Script example workflow CON_FUN_MP BUD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_CON_FUN_MP_BUD')) filesep 'example data CON-FUN_MP' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCONXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_BUD')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'connectivity' filesep 'GroupName1'], ...
    'BA', ba ...
    );

gr1_CON = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCONXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_BUD')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'connectivity' filesep 'GroupName2'], ...
    'BA', ba ...
    );

gr2_CON = im_gr2.get('GR');

%% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUNXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_BUD')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'functional' filesep 'GroupName1'], ...
    'BA', ba ...
    );

gr1_FUN = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUNXLS( ...
    'DIRECTORY', [fileparts(which('example_CON_FUN_MP_BUD')) filesep 'example data CON-FUN_MP' filesep 'xls' filesep 'functional' filesep 'GroupName2'], ...
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
a_BUD1 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'GR', gr1 ...
    );

a_BUD2 = AnalyzeEnsemble_CON_FUN_MP_BUD( ...
    'GR', gr2 ...
    );

% measure calculation
degree_BUD1 = a_BUD1.getMeasureEnsemble('Degree').get('M');
degree_av_BUD1 = a_BUD1.getMeasureEnsemble('DegreeAv').get('M');
distance_BUD1 = a_BUD1.getMeasureEnsemble('Distance').get('M');

degree_BUD2 = a_BUD2.getMeasureEnsemble('Degree').get('M');
degree_av_BUD2 = a_BUD2.getMeasureEnsemble('DegreeAv').get('M');
distance_BUD2 = a_BUD2.getMeasureEnsemble('Distance').get('M');

% comparison
c_BUD = CompareEnsemble( ...
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