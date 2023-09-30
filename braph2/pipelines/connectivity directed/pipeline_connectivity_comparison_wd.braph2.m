%% Pipeline Connectivity Comparison WD

% This is the pipeline script to compare two groups of subjects using connectivity data and weighted directed graphs.
% 1. It loads a brain atlas from an XLS file (e.g., desikan_atlas.xlsx).
% 2. It loads the data of two groups of subjects from two directories (e.g., GroupName1 and GroupName2) containing XLS files of each subject.
% 3. It analyzes the first group using connectivity analyses (CON) based on weighted directed graphs (WD).
% 4. It analyzes the second group using the same parameters selected for the first group.
% 5. It compares the results of the two analyses.

%% Brain Atlas
ba = ImporterBrainAtlasXLS('WAITBAR', true).get('GET_FILE').get('BA'); % Load a Brain Atlas XLS % Brain Atlas

%% Groups
gr1 = ImporterGroupSubjectCON_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR'); % Load Group CON 1 from XLS % Group CON 1
gr2 = ImporterGroupSubjectCON_XLS('BA', ba, 'WAITBAR', true).get('GET_DIR').get('GR'); % Load Group CON 2 from XLS % Group CON 2

%% Analysis 1
a_WD1 = AnalyzeEnsemble_CON_WD('GR', gr1); % Analyze Group 1 % Group 1 Analysis

%% Analysis 2
a_WD2 = AnalyzeEnsemble_CON_WD('GR', gr2, 'TEMPLATE', a_WD1); % Analyze Group 2 % Group 2 Analysis

%% Comparison
c_WD = CompareEnsemble('P', 100, 'A1', a_WD1, 'A2', a_WD2, 'MEMORIZE', true); % Compare Groups % Group Comparison