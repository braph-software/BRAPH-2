%EXAMPLE_ST_WU
% Script example pipeline ST WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'destrieux_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST WU
a_WU1 = AnalyzeGroup_ST_WU('GR', gr1, 'CORRELATION_RULE', Correlation.PEARSON_CV);
a_WU2 = AnalyzeGroup_ST_WU('GR', gr2, 'CORRELATION_RULE', Correlation.PEARSON_CV);

% measure calculation
g_WU1 = a_WU1.get('G');
strength_WU1 = g_WU1.getMeasure('Strength').get('M');
strength_av_WU1 = g_WU1.getMeasure('StrengthAv').get('M');
distance_WU1 = g_WU1.getMeasure('Distance').get('M');

g_WU2 = a_WU2.get('G');
strength_WU2 = g_WU2.getMeasure('Strength').get('M');
strength_av_WU2 = g_WU2.getMeasure('StrengthAv').get('M');
distance_WU2 = g_WU2.getMeasure('Distance').get('M');

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

strength_av_WU_diff = c_WU.getComparison('StrengthAv').get('DIFF');
strength_av_WU_p1 = c_WU.getComparison('StrengthAv').get('P1');
strength_av_WU_p2 = c_WU.getComparison('StrengthAv').get('P2');
strength_av_WU_cil = c_WU.getComparison('StrengthAv').get('CIL');
strength_av_WU_ciu = c_WU.getComparison('StrengthAv').get('CIU');