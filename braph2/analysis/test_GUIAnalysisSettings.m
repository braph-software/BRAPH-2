% test GUIAnalysisSettings

%% Pass type of analysis
GUIAnalysisSettings('AnalysisST_WU')

set(gcf, 'CloseRequestFcn', 'closereq')
close(gcf)

%% Pass a ST cohort
cohort_file = [fileparts(which('example_workflow_ST_WU.m')) filesep() 'example data ST (MRI)' filesep() 'cohort_example.cohort'];
temp = load(cohort_file, '-mat', 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
cohort = temp.cohort;

GUIAnalysisSettings(cohort, 'AnalysisST_BUD')

set(gcf, 'CloseRequestFcn', 'closereq')
close(gcf)

%% Pass a FNC cohort
cohort_file = [fileparts(which('example_workflow_FNC_WU.m')) filesep() 'example data FNC (fMRI)' filesep() 'cohort_example.cohort'];
temp = load(cohort_file, '-mat', 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
cohort = temp.cohort;

GUIAnalysisSettings(cohort, 'AnalysisFNC_BUD')

% set(gcf, 'CloseRequestFcn', 'closereq')
% close(gcf)
