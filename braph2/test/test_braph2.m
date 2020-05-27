% Test BRAPH by running all unit tests

close all
clear variables
clc

%% Identifies test directories
directory = fileparts(which('braph2'));

directories_to_test = { ...
    [directory filesep 'util'] ...
    [directory filesep 'graph'] ...
    [directory filesep 'graph' filesep 'graphs'] ...
    [directory filesep 'graph' filesep 'measures'] ...
    [directory filesep 'atlas'] ...
%     [directory filesep 'cohort'] ...
%     [directory filesep 'cohort' filesep 'datas'] ...
%     [directory filesep 'analysis'] ...
%     [directory filesep 'workflows'] ...
    };

addpath([directory filesep 'workflows'])
workflows_directories = dir([directory filesep 'workflows']);  % get the folder contents
workflows_directories = workflows_directories([workflows_directories(:).isdir] == 1);  % remove all files (isdir property is 0)
workflows_directories = workflows_directories(~ismember({workflows_directories(:).name}, {'.', '..'}));  % remove '.' and '..'
for i = 1:1:length(workflows_directories)
    directories_to_test{end + 1} = [directory filesep 'workflows' filesep workflows_directories(i).name]; %#ok<SAGROW>
end
clear directory workflows_directories i

%% Runs tests
results = runtests(directories_to_test);

%% Shows test results
results_table = table(results) %#ok<NOPTS>

if all([results(:).Passed])
    disp('*** All good! ***')
else
    disp('*** Something went wrong! ***')
end