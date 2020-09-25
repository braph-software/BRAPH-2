% test GUIAnalysis

%% Init ST

analysis_file = [fileparts(which('example_workflow_ST_WU.m')) filesep() 'example data ST (MRI)' filesep() 'analysis_example_ST_BUT.analysis'];
temp = load(analysis_file, '-mat', 'ga', 'BUILD');
ga = temp.ga;

GUIAnalysis(ga)

set(gcf, 'CloseRequestFcn', 'closereq')
close(gcf)