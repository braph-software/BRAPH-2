%EXAMPLE_FUN_WU_GROUP
% Script example pipeline FUN GA WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectFUN')) filesep 'example data FUN (fMRI)' filesep 'aal90_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis FUN WU GROUP
a_WU1 = AnalyzeGroup_FUN_GA_WU( ...
    'GR', gr1 ...
    );

a_WU2 = AnalyzeGroup_FUN_GA_WU( ...
    'GR', gr2 ...
    );

% measure calculation
g_WU1 = a_WU1.get('G');
strength_WU1 = g_WU1.getMeasure('Strength').get('M');
modularity_WU1 = g_WU1.getMeasure('Modularity').get('M');

g_WU2 = a_WU2.get('G');
strength_WU2 = g_WU2.getMeasure('Strength').get('M');
modularity_WU2 = g_WU2.getMeasure('Modularity').get('M');

% comparison
c_WU = CompareGroup( ...
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

strength_WU_diff = c_WU.getComparison('Strength').get('DIFF');
strength_WU_p1 = c_WU.getComparison('Strength').get('P1');
strength_WU_p2 = c_WU.getComparison('Strength').get('P2');
strength_WU_cil = c_WU.getComparison('Strength').get('CIL');
strength_WU_ciu = c_WU.getComparison('Strength').get('CIU');

modularity_WU_diff = c_WU.getComparison('Modularity').get('DIFF');
modularity_WU_p1 = c_WU.getComparison('Modularity').get('P1');
modularity_WU_p2 = c_WU.getComparison('Modularity').get('P2');
modularity_WU_ciu = c_WU.getComparison('Modularity').get('CIU');