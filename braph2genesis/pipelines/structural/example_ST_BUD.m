%EXAMPLE_ST_BUD
% Script example pipeline ST BUD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'Example data ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'Example data ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'Example data ST XLS' filesep 'ST_Group_2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis BUD
densities = 5:10:35;

a_BUD1 = AnalyzeGroup_ST_BUD('GR', gr1, 'DENSITIES', densities);

a_BUD2 = AnalyzeGroup_ST_BUD('GR', gr2, 'DENSITIES', densities);

% measure calculation
g_BUD1 = a_BUD1.get('G');
degree_BUD_1 = g_BUD1.get('MEASURE', 'Degree').get('M');
degree_av_BUD_1 = g_BUD1.get('MEASURE', 'DegreeAv').get('M');
distance_BUD_1 = g_BUD1.get('MEASURE', 'Distance').get('M');

g_BUD2 = a_BUD2.get('G');
degree_BUD_2 = g_BUD2.get('MEASURE', 'Degree').get('M');
degree_av_BUD_2 = g_BUD2.get('MEASURE', 'DegreeAv').get('M');
distance_BUD_2 = g_BUD2.get('MEASURE', 'Distance').get('M');

% comparison
% % % c_BUD = CompareGroup( ...
% % %     'P', 10, ...
% % %     'A1', a_BUD1, ...
% % %     'A2', a_BUD2, ...
% % %     'WAITBAR', true, ...
% % %     'VERBOSE', false, ...
% % %     'MEMORIZE', true ...
% % %     );
% % % 
% % % degree_BUD_diff = c_BUD.getComparison('Degree').get('DIFF');
% % % degree_BUD_p1 = c_BUD.getComparison('Degree').get('P1');
% % % degree_BUD_p2 = c_BUD.getComparison('Degree').get('P2');
% % % degree_BUD_cil = c_BUD.getComparison('Degree').get('CIL');
% % % degree_BUD_ciu = c_BUD.getComparison('Degree').get('CIU');
% % % 
% % % degree_av_BUD_diff = c_BUD.getComparison('DegreeAv').get('DIFF');
% % % degree_av_BUD_p1 = c_BUD.getComparison('DegreeAv').get('P1');
% % % degree_av_BUD_p2 = c_BUD.getComparison('DegreeAv').get('P2');
% % % degree_av_BUD_cil = c_BUD.getComparison('DegreeAv').get('CIL');
% % % degree_av_BUD_ciu = c_BUD.getComparison('DegreeAv').get('CIU');
