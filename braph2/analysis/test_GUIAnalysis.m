% test GUIAnalysis

%% Init ST

analysis_file = [fileparts(which('example_workflow_CON_WU.m')) filesep() 'example data CON (DTI)' filesep() 'analysis_example_CON_WU.analysis'];
temp = load(analysis_file, '-mat', 'ga', 'BUILD');
ga = temp.ga;

GUIAnalysis(ga)

set(gcf, 'CloseRequestFcn', 'closereq')
close(gcf)