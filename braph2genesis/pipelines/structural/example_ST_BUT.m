%EXAMPLE_ST_BUT
% Script example pipeline ST BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'Example data ST XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_BUT')) filesep 'Example data ST XLS' filesep 'ST_Group_1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_BUT')) filesep 'Example data ST XLS' filesep 'ST_Group_2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis BUT
thresholds = .4:.2:1;

a_BUT1 = AnalyzeGroup_ST_BUT('GR', gr1, 'THRESHOLDS', thresholds);

a_BUT2 = AnalyzeGroup_ST_BUT('GR', gr2, 'THRESHOLDS', thresholds);

% measure calculation
g_BUT1 = a_BUT1.get('G');
degree_BUT1 = g_BUT1.get('MEASURE', 'Degree').get('M');
degree_av_BUT1 = g_BUT1.get('MEASURE', 'DegreeAv').get('M');
distance_BUT1 = g_BUT1.get('MEASURE', 'Distance').get('M');

g_BUT2 = a_BUT2.get('G');
degree_BUT1 = g_BUT2.get('MEASURE', 'Degree').get('M');
degree_av_BUT1 = g_BUT2.get('MEASURE', 'DegreeAv').get('M');
distance_BUT1 = g_BUT2.get('MEASURE', 'Distance').get('M');

% comparison
% % % c_BUT = CompareGroup( ...
% % %     'P', 10, ...
% % %     'A1', a_BUT1, ...
% % %     'A2', a_BUT2, ...
% % %     'WAITBAR', true, ...
% % %     'VERBOSE', false, ...
% % %     'MEMORIZE', true ...
% % %     );
% % % 
% % % degree_BUT_diff = c_BUT.getComparison('Degree').get('DIFF');
% % % degree_BUT_p1 = c_BUT.getComparison('Degree').get('P1');
% % % degree_BUT_p2 = c_BUT.getComparison('Degree').get('P2');
% % % degree_BUT_cil = c_BUT.getComparison('Degree').get('CIL');
% % % degree_BUT_ciu = c_BUT.getComparison('Degree').get('CIU');
% % % 
% % % degree_av_BUT_diff = c_BUT.getComparison('DegreeAv').get('DIFF');
% % % degree_av_BUT_p1 = c_BUT.getComparison('DegreeAv').get('P1');
% % % degree_av_BUT_p2 = c_BUT.getComparison('DegreeAv').get('P2');
% % % degree_av_BUT_cil = c_BUT.getComparison('DegreeAv').get('CIL');
% % % degree_av_BUT_ciu = c_BUT.getComparison('DegreeAv').get('CIU');
