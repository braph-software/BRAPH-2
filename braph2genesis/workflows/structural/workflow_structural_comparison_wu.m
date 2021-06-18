% Workflow Structural Analysis WU

% ID - Workflow of Structural Analysis WU

% This is the workflow script to create an analysis of a group of subjects
% with structural data and a weighted undirected graph.
% Brain Atlas is set to Desikan Atlas example BrainAtlas. 
% Group is set to example group. Modify the path of the files to your needs.

%% BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Groups
%%% XLS
im_gr1 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr.get('GR');

im_gr2 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Comparison
%%% WU
a_WU1 = AnalyzeGroup_ST_WU('GR', gr1, 'CORRELATION_RULE', 'partial pearson', 'USE_COVARIATES', use_covariates_in_analysis);
a_WU2 = AnalyzeGroup_ST_WU('GR', gr2, 'CORRELATION_RULE', 'partial pearson', 'USE_COVARIATES', use_covariates_in_analysis);


c_WU = CompareGroup( ...
    'P', 10, ...
    'A1', a_WU1, ...
    'A2', a_WU2, ...
    'VERBOSE', true, ...
    'MEMORIZE', true ...
    );

