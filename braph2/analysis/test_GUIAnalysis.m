% test GUIAnalysis

%% Pass an atlas and type of analysis
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_workflow_ST_WU.m')) filesep() 'example data ST (MRI)' filesep() 'desikan_atlas.xlsx'];
end
clear file filterindex path

atlas = BrainAtlas.load_from_xls('File', atlas_file);

GUIAnalysis('AnalysisST_WU', atlas)

%% Pass a cohort
% [file, path, filterindex] = uigetfile('*.cohort');
% if filterindex
%     cohort_file = fullfile(path, file);
% else
%     cohort_file = [fileparts(which('example_workflow_ST_WU.m')) filesep() 'example data ST (MRI)' filesep() 'cohort_example.cohort'];
% end
% clear file filterindex path
% 
% temp = load(cohort_file, '-mat', 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
% cohort = temp.cohort;
% 
% GUIAnalysis(cohort)